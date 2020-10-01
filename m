Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E03627FCA5
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Oct 2020 11:48:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731861AbgJAJsE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Oct 2020 05:48:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731670AbgJAJsE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Oct 2020 05:48:04 -0400
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64020C0613D0
        for <linux-kernel@vger.kernel.org>; Thu,  1 Oct 2020 02:48:02 -0700 (PDT)
Received: by mail-lf1-x141.google.com with SMTP id z19so5793990lfr.4
        for <linux-kernel@vger.kernel.org>; Thu, 01 Oct 2020 02:48:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=QXUHOUOIRQLQSk+oL7ASSbi4r+Kj7C474rkiHvSTLl4=;
        b=vCc44CG8R2Ck37hH0p29Hs87ppHzpnVmGK9DTli7HMNhmEND36Acrt7xjVvEDBqsLn
         7PUJbqa3SvoBhZ5m4Baukx6zjo09HCl8HeN+ENV8SRJRik2L98UqqPnOJ/GQ+Dws7ZFE
         5KcmfglpFVNwjs8p4Yt525V3HzBQY7zvTgfn82cDjZWiZZYS8Olax1Es5Bt9XifWWtUQ
         YIL4E6q6AayNIywkTHzrkLAGsQWf2rORjyS/oXO5+HhroI1J5BQCfNTwPQjkOx71RRNq
         oynucng3ESLOOH8qfATcillhJfPJisFGiN58jdQqmLepT0VBWpDXdX/b6H5oXK7nCpqL
         H2Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=QXUHOUOIRQLQSk+oL7ASSbi4r+Kj7C474rkiHvSTLl4=;
        b=A8iqYTrWv/iRClXvDJ/p5E+zl7w3coZrneuAo19/8Xlv274P090BxJJkGkr4qSHzXA
         B+tEiFQK1cAu36U5bi67whUo5zNa+RgNMWI02si4QqzNpggmZH+5UAC0AOJahRsVLBU1
         VdwvXVGRi0hD1SxR9105IE1hKvos0Hx+Q2XxDzV4ubYPcZbOB4itMmsmgm9x171bQ2Fo
         maVLvALkNyK7JlqQ4O4kZ3Zs42c6BabCY7vJmwH1AhZrsr/PjVKmha6VzIf8zvYeSoq7
         Ah0MRhHSpcQEc6boiryGaMs6mLxHxapc+LsNY7yr26ARlJ+bNaWk74HotwwZ+sbQFMXO
         HLjQ==
X-Gm-Message-State: AOAM532iZC3k0NOG05CMQCJ7P+0fZE6nSMK0tVVj+LYtYOEckaoIdlG5
        RHnzE26ARhAPzBWnIPqOLVE/QQ==
X-Google-Smtp-Source: ABdhPJwQ7Cr8xjtr1g6nU5YcWypivGAr9RQKgjFyufNuo3bGtfd8tdZv2aaYOmKNZeOg5FSd/e5SXQ==
X-Received: by 2002:a05:6512:419:: with SMTP id u25mr2477458lfk.81.1601545680689;
        Thu, 01 Oct 2020 02:48:00 -0700 (PDT)
Received: from jade (h-249-223.A175.priv.bahnhof.se. [98.128.249.223])
        by smtp.gmail.com with ESMTPSA id 10sm497187lfq.64.2020.10.01.02.47.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Oct 2020 02:48:00 -0700 (PDT)
Date:   Thu, 1 Oct 2020 11:47:58 +0200
From:   Jens Wiklander <jens.wiklander@linaro.org>
To:     Elvira Khabirova <e.khabirova@omprussia.ru>
Cc:     op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org,
        k.karasev@omprussia.ru, s.shtylyov@omprussia.ru,
        vesa.jaaskelainen@vaisala.com
Subject: Re: [PATCH v2] tee: add support for application-based session login
 methods
Message-ID: <20201001094758.GA928596@jade>
References: <20200930195652.5c316c3e@akathisia>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200930195652.5c316c3e@akathisia>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 30, 2020 at 07:56:52PM +0300, Elvira Khabirova wrote:
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
>  drivers/tee/tee_core.c | 133 ++++++++++++++++++++++++++++++++++++++---
>  2 files changed, 154 insertions(+), 8 deletions(-)

This looks good as far as I can tell, with just one small comment below.
However, I'd like someone else to review this too.

> 
> diff --git a/drivers/tee/Kconfig b/drivers/tee/Kconfig
> index 6488b66d69dd..cd8f02a3d488 100644
> --- a/drivers/tee/Kconfig
> +++ b/drivers/tee/Kconfig
> @@ -10,6 +10,35 @@ config TEE
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
> index 67186d00a52f..31fb244b59ed 100644
> --- a/drivers/tee/tee_core.c
> +++ b/drivers/tee/tee_core.c
> @@ -16,9 +16,12 @@
>  
>  #include <linux/cdev.h>
>  #include <linux/cred.h>
> +#include <linux/file.h>
>  #include <linux/fs.h>
>  #include <linux/idr.h>
> +#include <linux/mm.h>
>  #include <linux/module.h>
> +#include <linux/security.h>
>  #include <linux/slab.h>
>  #include <linux/tee_drv.h>
>  #include <linux/uaccess.h>
> @@ -31,7 +34,7 @@
>  
>  #define TEE_IOCTL_PARAM_SIZE(x) (sizeof(struct tee_param) * (x))
>  
> -#define TEE_UUID_NS_NAME_SIZE	128
> +#define TEE_UUID_NS_NAME_SIZE	PATH_MAX
>  
>  /*
>   * TEE Client UUID name space identifier (UUIDv4)
> @@ -136,6 +139,72 @@ static int tee_release(struct inode *inode, struct file *filp)
>  	return 0;
>  }
>  
> +#ifdef CONFIG_TEE_APPID_SECURITY
> +static const char *get_app_id(void **data)
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
> +	/*
> +	 * An identifier string for the binary. Depends on the implementation.
> +	 * Could be, for example, a string containing the application vendor ID,
> +	 * or the binary's signature, or its hash and a timestamp.
> +	 */
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
> +static const char *get_app_id(void **data)
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
> +static void free_app_id(void *data)
> +{
> +	kfree(data);
> +}
> +#endif /* CONFIG_TEE_APPID_PATH || CONFIG_TEE_APPID_SECURITY */
I don't think we need this function, we could just as well use kfree()
directly instead.

Thanks,
Jens

> +
>  /**
>   * uuid_v5() - Calculate UUIDv5
>   * @uuid: Resulting UUID
> @@ -208,6 +277,8 @@ int tee_session_calc_client_uuid(uuid_t *uuid, u32 connection_method,
>  	gid_t ns_grp = (gid_t)-1;
>  	kgid_t grp = INVALID_GID;
>  	char *name = NULL;
> +	void *app_id_data = NULL;
> +	const char *app_id = NULL;
>  	int name_len;
>  	int rc;
>  
> @@ -228,6 +299,14 @@ int tee_session_calc_client_uuid(uuid_t *uuid, u32 connection_method,
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
> @@ -238,10 +317,6 @@ int tee_session_calc_client_uuid(uuid_t *uuid, u32 connection_method,
>  	case TEE_IOCTL_LOGIN_USER:
>  		name_len = snprintf(name, TEE_UUID_NS_NAME_SIZE, "uid=%x",
>  				    current_euid().val);
> -		if (name_len >= TEE_UUID_NS_NAME_SIZE) {
> -			rc = -E2BIG;
> -			goto out_free_name;
> -		}
>  		break;
>  
>  	case TEE_IOCTL_LOGIN_GROUP:
> @@ -254,10 +329,49 @@ int tee_session_calc_client_uuid(uuid_t *uuid, u32 connection_method,
>  
>  		name_len = snprintf(name, TEE_UUID_NS_NAME_SIZE, "gid=%x",
>  				    grp.val);
> -		if (name_len >= TEE_UUID_NS_NAME_SIZE) {
> -			rc = -E2BIG;
> +		break;
> +
> +	case TEE_IOCTL_LOGIN_APPLICATION:
> +		app_id = get_app_id(&app_id_data);
> +		if (IS_ERR(app_id)) {
> +			rc = PTR_ERR(app_id);
> +			goto out_free_name;
> +		}
> +
> +		name_len = snprintf(name, TEE_UUID_NS_NAME_SIZE, "app=%s",
> +				    app_id);
> +		free_app_id(app_id_data);
> +		break;
> +
> +	case TEE_IOCTL_LOGIN_USER_APPLICATION:
> +		app_id = get_app_id(&app_id_data);
> +		if (IS_ERR(app_id)) {
> +			rc = PTR_ERR(app_id);
> +			goto out_free_name;
> +		}
> +
> +		name_len = snprintf(name, TEE_UUID_NS_NAME_SIZE, "uid=%x:app=%s",
> +				    current_euid().val, app_id);
> +		free_app_id(app_id_data);
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
> +		app_id = get_app_id(&app_id_data);
> +		if (IS_ERR(app_id)) {
> +			rc = PTR_ERR(app_id);
>  			goto out_free_name;
>  		}
> +
> +		name_len = snprintf(name, TEE_UUID_NS_NAME_SIZE, "gid=%x:app=%s",
> +				    grp.val, app_id);
> +		free_app_id(app_id_data);
>  		break;
>  
>  	default:
> @@ -265,7 +379,10 @@ int tee_session_calc_client_uuid(uuid_t *uuid, u32 connection_method,
>  		goto out_free_name;
>  	}
>  
> -	rc = uuid_v5(uuid, &tee_client_uuid_ns, name, name_len);
> +	if (name_len < TEE_UUID_NS_NAME_SIZE)
> +		rc = uuid_v5(uuid, &tee_client_uuid_ns, name, name_len);
> +	else
> +		rc = -E2BIG;
>  out_free_name:
>  	kfree(name);
>  
> -- 
> 2.17.1
> 
