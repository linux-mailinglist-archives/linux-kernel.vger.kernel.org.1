Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46C8C27FCB8
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Oct 2020 11:58:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731619AbgJAJ6R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Oct 2020 05:58:17 -0400
Received: from mxout03.lancloud.ru ([89.108.73.187]:40672 "EHLO
        mxout03.lancloud.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726992AbgJAJ6P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Oct 2020 05:58:15 -0400
Received: from LanCloud
DKIM-Filter: OpenDKIM Filter v2.11.0 mxout03.lancloud.ru 446272094BE5
Received: from LanCloud
Received: from LanCloud
Received: from LanCloud
Date:   Thu, 1 Oct 2020 12:58:10 +0300
From:   Elvira Khabirova <e.khabirova@omprussia.ru>
To:     Jens Wiklander <jens.wiklander@linaro.org>
CC:     <op-tee@lists.trustedfirmware.org>, <linux-kernel@vger.kernel.org>,
        <k.karasev@omprussia.ru>, <s.shtylyov@omprussia.ru>,
        <vesa.jaaskelainen@vaisala.com>
Subject: Re: [PATCH v2] tee: add support for application-based session login
 methods
Message-ID: <20201001125810.5ff84815@akathisia>
In-Reply-To: <20201001094758.GA928596@jade>
References: <20200930195652.5c316c3e@akathisia>
        <20201001094758.GA928596@jade>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [89.255.69.56]
X-ClientProxiedBy: LFEXT02.lancloud.ru (fd00:f066::142) To
 LFEX1903.lancloud.ru (fd00:f066::73)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 1 Oct 2020 11:47:58 +0200
Jens Wiklander <jens.wiklander@linaro.org> wrote:

> On Wed, Sep 30, 2020 at 07:56:52PM +0300, Elvira Khabirova wrote:
> > +#if defined(CONFIG_TEE_APPID_PATH) || defined(CONFIG_TEE_APPID_SECURITY)
> > +static void free_app_id(void *data)
> > +{
> > +	kfree(data);
> > +}
> > +#endif /* CONFIG_TEE_APPID_PATH || CONFIG_TEE_APPID_SECURITY */
> I don't think we need this function, we could just as well use kfree()
> directly instead.

Ah, I supposed "use the pattern you're already using" meant to keep
the freeing function too. My bad.

> Thanks,
> Jens
> 
> > +
> >  /**
> >   * uuid_v5() - Calculate UUIDv5
> >   * @uuid: Resulting UUID
> > @@ -208,6 +277,8 @@ int tee_session_calc_client_uuid(uuid_t *uuid, u32 connection_method,
> >  	gid_t ns_grp = (gid_t)-1;
> >  	kgid_t grp = INVALID_GID;
> >  	char *name = NULL;
> > +	void *app_id_data = NULL;
> > +	const char *app_id = NULL;
> >  	int name_len;
> >  	int rc;
> >  
> > @@ -228,6 +299,14 @@ int tee_session_calc_client_uuid(uuid_t *uuid, u32 connection_method,
> >  	 * For TEEC_LOGIN_GROUP:
> >  	 * gid=<gid>
> >  	 *
> > +	 * For TEEC_LOGIN_APPLICATION:
> > +	 * app=<application id>
> > +	 *
> > +	 * For TEEC_LOGIN_USER_APPLICATION:
> > +	 * uid=<uid>:app=<application id>
> > +	 *
> > +	 * For TEEC_LOGIN_GROUP_APPLICATION:
> > +	 * gid=<gid>:app=<application id>
> >  	 */
> >  
> >  	name = kzalloc(TEE_UUID_NS_NAME_SIZE, GFP_KERNEL);
> > @@ -238,10 +317,6 @@ int tee_session_calc_client_uuid(uuid_t *uuid, u32 connection_method,
> >  	case TEE_IOCTL_LOGIN_USER:
> >  		name_len = snprintf(name, TEE_UUID_NS_NAME_SIZE, "uid=%x",
> >  				    current_euid().val);
> > -		if (name_len >= TEE_UUID_NS_NAME_SIZE) {
> > -			rc = -E2BIG;
> > -			goto out_free_name;
> > -		}
> >  		break;
> >  
> >  	case TEE_IOCTL_LOGIN_GROUP:
> > @@ -254,10 +329,49 @@ int tee_session_calc_client_uuid(uuid_t *uuid, u32 connection_method,
> >  
> >  		name_len = snprintf(name, TEE_UUID_NS_NAME_SIZE, "gid=%x",
> >  				    grp.val);
> > -		if (name_len >= TEE_UUID_NS_NAME_SIZE) {
> > -			rc = -E2BIG;
> > +		break;
> > +
> > +	case TEE_IOCTL_LOGIN_APPLICATION:
> > +		app_id = get_app_id(&app_id_data);
> > +		if (IS_ERR(app_id)) {
> > +			rc = PTR_ERR(app_id);
> > +			goto out_free_name;
> > +		}
> > +
> > +		name_len = snprintf(name, TEE_UUID_NS_NAME_SIZE, "app=%s",
> > +				    app_id);
> > +		free_app_id(app_id_data);
> > +		break;
> > +
> > +	case TEE_IOCTL_LOGIN_USER_APPLICATION:
> > +		app_id = get_app_id(&app_id_data);
> > +		if (IS_ERR(app_id)) {
> > +			rc = PTR_ERR(app_id);
> > +			goto out_free_name;
> > +		}
> > +
> > +		name_len = snprintf(name, TEE_UUID_NS_NAME_SIZE, "uid=%x:app=%s",
> > +				    current_euid().val, app_id);
> > +		free_app_id(app_id_data);
> > +		break;
> > +
> > +	case TEE_IOCTL_LOGIN_GROUP_APPLICATION:
> > +		memcpy(&ns_grp, connection_data, sizeof(gid_t));
> > +		grp = make_kgid(current_user_ns(), ns_grp);
> > +		if (!gid_valid(grp) || !in_egroup_p(grp)) {
> > +			rc = -EPERM;
> > +			goto out_free_name;
> > +		}
> > +
> > +		app_id = get_app_id(&app_id_data);
> > +		if (IS_ERR(app_id)) {
> > +			rc = PTR_ERR(app_id);
> >  			goto out_free_name;
> >  		}
> > +
> > +		name_len = snprintf(name, TEE_UUID_NS_NAME_SIZE, "gid=%x:app=%s",
> > +				    grp.val, app_id);
> > +		free_app_id(app_id_data);
> >  		break;
> >  
> >  	default:
> > @@ -265,7 +379,10 @@ int tee_session_calc_client_uuid(uuid_t *uuid, u32 connection_method,
> >  		goto out_free_name;
> >  	}
> >  
> > -	rc = uuid_v5(uuid, &tee_client_uuid_ns, name, name_len);
> > +	if (name_len < TEE_UUID_NS_NAME_SIZE)
> > +		rc = uuid_v5(uuid, &tee_client_uuid_ns, name, name_len);
> > +	else
> > +		rc = -E2BIG;
> >  out_free_name:
> >  	kfree(name);
> >  
> > -- 
> > 2.17.1
> > 

