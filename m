Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E23527AF4B
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Sep 2020 15:43:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726526AbgI1Nnw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Sep 2020 09:43:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726409AbgI1Nnw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Sep 2020 09:43:52 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A15B5C061755
        for <linux-kernel@vger.kernel.org>; Mon, 28 Sep 2020 06:43:51 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id a22so1058491ljp.13
        for <linux-kernel@vger.kernel.org>; Mon, 28 Sep 2020 06:43:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Qh0yK92s/b9iAlyp4ipnt9oqc15IVBpnV3UpvHl7dlI=;
        b=AYTXCpE8419HNtq8w60fJz2r9wxiCncsanG4tClLYQ10G/zLXqRr9PR8jNsQX5Fqm9
         VaV8dTDIUlirLAR762Tt8peHyjj+0IqJZIulvVIrbSng+0F2xUrCqTHzdrysjRT3PILG
         n0q/SdVWYw3Ivvo/4qntsJzCBG0yzzbUsciiXFlqr3GPLfIXc6HajLkCLhshwq6j7MwO
         8Q1lovX/F8MV4Dijaj3EBTQ8x1tt9kkvJnFy34806o76JlOB5MHjsDoMQvhfG6scKUCe
         HML4d0/k+isnUDV37WZBC1yk0eJXWnJnE2urg8U33nc8SmKyyukaXPMKF7HgFU/HLQO7
         /9ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Qh0yK92s/b9iAlyp4ipnt9oqc15IVBpnV3UpvHl7dlI=;
        b=Q44++y/1EQZpn4UA858GNMy2uJ4ZkmRTZm8dmECKNkjKIArxvkRXywjYvwOZVS1DNH
         ejnS/2VqTDsZFzp9uC4aU1Z3QRDjdKxkYcNFKP31vgdud8q7rAaNDkYy5Osv4GBjEDNI
         s25kzM5PMw3PsQQiFB39ZEUTrNaNkFFX2KHVipu5C3imedZ6KnU15uiQt7f9sbKZ5T2h
         P/Mh+e4tPuC67HMQRN1tHm4dZf01/rWw6m6eyiHRRQi1pzAmbaNeXARh3BYMHfM8gEFY
         kjpL8dRh88iT8CrX6BXECj5q8gw0LtNCP9TRt6Cx6eKgEavnNlwo156MViEjMuAzgI19
         0pUA==
X-Gm-Message-State: AOAM5316g8i7OWkvdJtsN5HyqvmggMsgDJ+CULXGf4PcSOiOFzHQhTgp
        ZNySclrNpqE+KrEzaX+l0b+u3w==
X-Google-Smtp-Source: ABdhPJzowR8qhsDF/cpr0ij+6/SQ4cEPYhv7H9uWbyM2koBT8GNpYMeB42qqeCMU95g9tXnV7x1Frg==
X-Received: by 2002:a2e:8758:: with SMTP id q24mr451218ljj.162.1601300630015;
        Mon, 28 Sep 2020 06:43:50 -0700 (PDT)
Received: from jade (h-249-223.A175.priv.bahnhof.se. [98.128.249.223])
        by smtp.gmail.com with ESMTPSA id b134sm2832258lfg.147.2020.09.28.06.43.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2020 06:43:49 -0700 (PDT)
Date:   Mon, 28 Sep 2020 15:43:47 +0200
From:   Jens Wiklander <jens.wiklander@linaro.org>
To:     Elvira Khabirova <e.khabirova@omprussia.ru>
Cc:     op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org,
        vesa.jaaskelainen@vaisala.com, s.shtylyov@omprussia.ru,
        k.karasev@omprussia.ru
Subject: Re: [RFC PATCH] tee: add support for application-based session login
 methods
Message-ID: <20200928134347.GA76106@jade>
References: <20200917183803.4a0c5263@akathisia>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200917183803.4a0c5263@akathisia>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Elvira,

On Thu, Sep 17, 2020 at 06:38:03PM +0300, Elvira Khabirova wrote:
> GP TEE Client API in addition to login methods already supported
> in the kernel also defines several application-based methods:
> TEEC_LOGIN_APPLICATION, TEEC_LOGIN_USER_APPLICATION, and
> TEEC_LOGIN_GROUP_APPLICATION.
> 
> It specifies credentials generated for TEEC_LOGIN_APPLICATION as only
> depending on the identity of the program, being persistent within one
> implementation, across multiple invocations of the application
> and across power cycles, enabling them to be used to disambiguate
> persistent storage. The exact nature is REE-specific.
> 
> As the exact method of generating application identifier strings may
> vary between vendors, setups and installations, add two suggested
> methods and an exact framework for vendors to extend upon.
> 
> Signed-off-by: Elvira Khabirova <e.khabirova@omprussia.ru>
> ---
>  drivers/tee/Kconfig    |  29 +++++++++
>  drivers/tee/tee_core.c | 136 ++++++++++++++++++++++++++++++++++++++++-
>  2 files changed, 164 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/tee/Kconfig b/drivers/tee/Kconfig
> index e99d840c2511..4cd6e0d2aad5 100644
> --- a/drivers/tee/Kconfig
> +++ b/drivers/tee/Kconfig
> @@ -11,6 +11,35 @@ config TEE
>  	  This implements a generic interface towards a Trusted Execution
>  	  Environment (TEE).
>  
> +choice
> +	prompt "Application ID for client UUID"
> +	depends on TEE
> +	default TEE_APPID_PATH
> +	help
> +	  This option allows to choose which method will be used to generate
> +	  application identifiers for client UUID generation when login methods
> +	  TEE_LOGIN_APPLICATION, TEE_LOGIN_USER_APPLICATION
> +	  and TEE_LOGIN_GROUP_APPLICATION are used.
> +	  Please be mindful of the security of each method in your particular
> +	  installation.
> +
> +	config TEE_APPID_PATH
> +		bool "Path-based application ID"
> +		help
> +		  Use the executable's path as an application ID.
> +
> +	config TEE_APPID_SECURITY
> +		bool "Security extended attribute based application ID"
> +		help
> +		  Use the executable's security extended attribute as an application ID.
> +endchoice
> +
> +config TEE_APPID_SECURITY_XATTR
> +	string "Security extended attribute to use for application ID"
> +	depends on TEE_APPID_SECURITY
> +	help
> +	  Attribute to be used as an application ID (with the security prefix removed).
> +
>  if TEE
>  
>  menu "TEE drivers"
> diff --git a/drivers/tee/tee_core.c b/drivers/tee/tee_core.c
> index 64637e09a095..19c965dd212b 100644
> --- a/drivers/tee/tee_core.c
> +++ b/drivers/tee/tee_core.c
> @@ -7,8 +7,10 @@
>  
>  #include <linux/cdev.h>
>  #include <linux/cred.h>
> +#include <linux/file.h>
>  #include <linux/fs.h>
>  #include <linux/idr.h>
> +#include <linux/mm.h>
>  #include <linux/module.h>
>  #include <linux/slab.h>
>  #include <linux/tee_drv.h>
> @@ -17,11 +19,15 @@
>  #include <crypto/sha.h>
>  #include "tee_private.h"
>  
> +#ifdef CONFIG_TEE_APPID_SECURITY
No need for the ifdef, just inlude the file unconditionally above.

> +#include <linux/security.h>
> +#endif
> +
>  #define TEE_NUM_DEVICES	32
>  
>  #define TEE_IOCTL_PARAM_SIZE(x) (sizeof(struct tee_param) * (x))
>  
> -#define TEE_UUID_NS_NAME_SIZE	128
> +#define TEE_UUID_NS_NAME_SIZE	PATH_MAX
>  
>  /*
>   * TEE Client UUID name space identifier (UUIDv4)
> @@ -125,6 +131,67 @@ static int tee_release(struct inode *inode, struct file *filp)
>  	return 0;
>  }
>  
> +#ifdef CONFIG_TEE_APPID_SECURITY
> +static const char *tee_session_get_application_id(void **data)
static char *get_app_id(void) should be enough.

> +{
> +	struct file *exe_file;
> +	const char *name = CONFIG_TEE_APPID_SECURITY_XATTR;
> +	int len;
> +
> +	exe_file = get_mm_exe_file(current->mm);
> +	if (!exe_file)
> +		return ERR_PTR(-ENOENT);
> +
> +	if (!exe_file->f_inode) {
> +		fput(exe_file);
> +		return ERR_PTR(-ENOENT);
> +	}
> +

You could perhaps add a comment here on the expected properties of this
data. Something along (don't know if I'm even close) "string
representation of the the hash of the binary and time stamp".

> +	len = security_inode_getsecurity(exe_file->f_inode, name, data, true);
> +	if (len < 0)
> +		return ERR_PTR(len);
> +
> +	fput(exe_file);
> +
> +	return *data;
> +}
> +#endif /* CONFIG_TEE_APPID_SECURITY */
> +
> +#ifdef CONFIG_TEE_APPID_PATH
> +static const char *tee_session_get_application_id(void **data)
> +{
> +	struct file *exe_file;
> +	char *path;
> +
> +	*data = kzalloc(TEE_UUID_NS_NAME_SIZE, GFP_KERNEL);
> +	if (!*data)
> +		return ERR_PTR(-ENOMEM);
> +
> +	exe_file = get_mm_exe_file(current->mm);
> +	if (!exe_file) {
> +		kfree(*data);
> +		return ERR_PTR(-ENOENT);
> +	}
> +
> +	path = file_path(exe_file, *data, TEE_UUID_NS_NAME_SIZE);
> +	if (IS_ERR(path)) {
> +		kfree(*data);
> +		return path;
> +	}
> +
> +	fput(exe_file);
> +
> +	return path;
> +}
> +#endif /* CONFIG_TEE_APPID_PATH */
> +
> +#if defined(CONFIG_TEE_APPID_PATH) || defined(CONFIG_TEE_APPID_SECURITY)
> +static void tee_session_free_application_id(void *data)
> +{
> +	kfree(data);
> +}
This function isn't needed, we can call kfree() directly.

> +#endif /* CONFIG_TEE_APPID_PATH || CONFIG_TEE_APPID_SECURITY */
> +
>  /**
>   * uuid_v5() - Calculate UUIDv5
>   * @uuid: Resulting UUID
> @@ -197,6 +264,8 @@ int tee_session_calc_client_uuid(uuid_t *uuid, u32 connection_method,
>  	gid_t ns_grp = (gid_t)-1;
>  	kgid_t grp = INVALID_GID;
>  	char *name = NULL;
> +	void *application_id_data = NULL;
This isn't needed

> +	const char *application_id = NULL;
char *app_id = NULL;

>  	int name_len;
>  	int rc;
>  
> @@ -217,6 +286,14 @@ int tee_session_calc_client_uuid(uuid_t *uuid, u32 connection_method,
>  	 * For TEEC_LOGIN_GROUP:
>  	 * gid=<gid>
>  	 *
> +	 * For TEEC_LOGIN_APPLICATION:
> +	 * app=<application id>
> +	 *
> +	 * For TEEC_LOGIN_USER_APPLICATION:
> +	 * uid=<uid>:app=<application id>
> +	 *
> +	 * For TEEC_LOGIN_GROUP_APPLICATION:
> +	 * gid=<gid>:app=<application id>
>  	 */
>  
>  	name = kzalloc(TEE_UUID_NS_NAME_SIZE, GFP_KERNEL);
> @@ -249,6 +326,63 @@ int tee_session_calc_client_uuid(uuid_t *uuid, u32 connection_method,
>  		}
>  		break;
>  
> +	case TEE_IOCTL_LOGIN_APPLICATION:
> +		application_id = tee_session_get_application_id(&application_id_data);
> +		if (IS_ERR(application_id)) {
> +			rc = PTR_ERR(application_id);
> +			goto out_free_name;
> +		}
> +
> +		name_len = snprintf(name, TEE_UUID_NS_NAME_SIZE, "app=%s",
> +				    application_id);
> +		tee_session_free_application_id(application_id_data);
> +
> +		if (name_len >= TEE_UUID_NS_NAME_SIZE) {
> +			rc = -E2BIG;
> +			goto out_free_name;
> +		}
It looks like we remove these tests and replace them with
if (name_len < TEE_UUID_NS_NAME_SIZE)
        rc = uuid_v5(uuid, &tee_client_uuid_ns, name, name_len);
else
        rc = -E2BIG

below, just above the "out_free_name:" label.

This function is small and simple enough that it should be easy to see
what's going on any way.

Thanks,
Jens

> +		break;
> +
> +	case TEE_IOCTL_LOGIN_USER_APPLICATION:
> +		application_id = tee_session_get_application_id(&application_id_data);
> +		if (IS_ERR(application_id)) {
> +			rc = PTR_ERR(application_id);
> +			goto out_free_name;
> +		}
> +
> +		name_len = snprintf(name, TEE_UUID_NS_NAME_SIZE, "uid=%x:app=%s",
> +				    current_euid().val, application_id);
> +		tee_session_free_application_id(application_id_data);
> +
> +		if (name_len >= TEE_UUID_NS_NAME_SIZE) {
> +			rc = -E2BIG;
> +			goto out_free_name;
> +		}
> +		break;
> +
> +	case TEE_IOCTL_LOGIN_GROUP_APPLICATION:
> +		memcpy(&ns_grp, connection_data, sizeof(gid_t));
> +		grp = make_kgid(current_user_ns(), ns_grp);
> +		if (!gid_valid(grp) || !in_egroup_p(grp)) {
> +			rc = -EPERM;
> +			goto out_free_name;
> +		}
> +
> +		application_id = tee_session_get_application_id(&application_id_data);
> +		if (IS_ERR(application_id)) {
> +			rc = PTR_ERR(application_id);
> +			goto out_free_name;
> +		}
> +		name_len = snprintf(name, TEE_UUID_NS_NAME_SIZE, "gid=%x:app=%s",
> +				    grp.val, application_id);
> +		tee_session_free_application_id(application_id_data);
> +
> +		if (name_len >= TEE_UUID_NS_NAME_SIZE) {
> +			rc = -E2BIG;
> +			goto out_free_name;
> +		}
> +		break;
> +
>  	default:
>  		rc = -EINVAL;
>  		goto out_free_name;
> -- 
> 2.28.0
> 
