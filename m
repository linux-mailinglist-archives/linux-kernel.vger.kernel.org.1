Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70AB02D4D6A
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Dec 2020 23:18:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388349AbgLIWSN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Dec 2020 17:18:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727030AbgLIWR4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Dec 2020 17:17:56 -0500
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55C61C061793
        for <linux-kernel@vger.kernel.org>; Wed,  9 Dec 2020 14:17:16 -0800 (PST)
Received: by mail-wr1-x441.google.com with SMTP id i9so3428042wrc.4
        for <linux-kernel@vger.kernel.org>; Wed, 09 Dec 2020 14:17:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=79KmwtjGYcYf9XiMvPhz4ZWUJEGfLsXRhQWD7gmiScs=;
        b=XLibbmtJVcyb9IQyblkkdG+HmmOyY34UgFZe2EWav2EYy8vQntysX5S44/cqSRqXI/
         WbxNLNHVD2qVwZl9/pLdM+b/Xxxj7bfJcveeh6XUx43Fsceznqw32/O3vm5pN/fKswhM
         nZ2ZYCVJxruUjAhp6rT7Ags4QDp+hL96as8QU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=79KmwtjGYcYf9XiMvPhz4ZWUJEGfLsXRhQWD7gmiScs=;
        b=mdkDYm0wfaKPmE1GIdGiVctYwEgPgC3r7gTF49O5PMn9NKkCl0Kq7qRqIUvcPwUp/t
         CHSLertKLMv16r9HN27IWbUjRsTwddbeJN7IpIiYHi2b/Qcujed4jeVFX9qBgCvStEey
         c3csjVP+digZSnMQWYu6hk/wBBLYAe41hNu8xJz5IvrZLezI6I8fmO/amXjuJ1fQ6o80
         kjiGlMFGqtQuGkYSpcFpCKCjrMNZUYPfrdR+Jh3SeMpqLSD69oHod1oF5eA/dBkMWp+V
         8m6s01c2Nr2VqQlRC4MK6nwlf/iUdTUcuK0Z9yikQEQ5bUsn82R/xsxij4oSbBgvQREN
         9dMw==
X-Gm-Message-State: AOAM5326Cp8ojMizlf0YQmQ/UExZzNSvpE//4h4fyprFYR4Tm7CgWsCT
        Wa/f5D8GCmfw5iy/xO2MUBzFoQ==
X-Google-Smtp-Source: ABdhPJzpEoul1GN1qEB+vlnjNX2OsBJ/3OG5hYZd35Shr1mkpe0IGwF4WK5RjVsEHBVLInviEAGw3g==
X-Received: by 2002:adf:e705:: with SMTP id c5mr4709810wrm.303.1607552234937;
        Wed, 09 Dec 2020 14:17:14 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id r2sm5802355wrn.83.2020.12.09.14.17.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Dec 2020 14:17:13 -0800 (PST)
Date:   Wed, 9 Dec 2020 23:17:11 +0100
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Sumera Priyadarsini <sylphrenadin@gmail.com>
Cc:     melissa.srw@gmail.com, daniel@ffwll.ch, hamohammed.sa@gmail.com,
        rodrigosiqueiramelo@gmail.com, airlied@linux.ie,
        mripard@kernel.org, maarten.lankhorst@linux.intel.com,
        tzimmermann@suse.de, corbet@lwn.net,
        dri-devel@lists.freedesktop.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] drm/vkms: Add setup and testing information
Message-ID: <20201209221711.GC401619@phenom.ffwll.local>
Mail-Followup-To: Sumera Priyadarsini <sylphrenadin@gmail.com>,
        melissa.srw@gmail.com, hamohammed.sa@gmail.com,
        rodrigosiqueiramelo@gmail.com, airlied@linux.ie, mripard@kernel.org,
        maarten.lankhorst@linux.intel.com, tzimmermann@suse.de,
        corbet@lwn.net, dri-devel@lists.freedesktop.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20201209190453.c6kp5winikr55n3i@adolin>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201209190453.c6kp5winikr55n3i@adolin>
X-Operating-System: Linux phenom 5.7.0-1-amd64 
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 10, 2020 at 12:34:53AM +0530, Sumera Priyadarsini wrote:
> Update the vkms documentation to contain steps to:
> 
>  - setup the vkms driver
>  - run tests using igt
> 
> Signed-off-by: Sumera Priyadarsini <sylphrenadin@gmail.com>
> ___
> Changes in v2:
>  - Change heading to title case (Daniel)
>  - Add examples to run tests directly (Daniel)
>  - Add examples to run subtests (Melissa)
> 
> Changes in v3:
>  - Add example using run-tests.sh script(Daniel)

Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>

> ---
>  Documentation/gpu/vkms.rst | 70 ++++++++++++++++++++++++++++++++++++++
>  1 file changed, 70 insertions(+)
> 
> diff --git a/Documentation/gpu/vkms.rst b/Documentation/gpu/vkms.rst
> index 13bab1d93bb3..9e030c74a82e 100644
> --- a/Documentation/gpu/vkms.rst
> +++ b/Documentation/gpu/vkms.rst
> @@ -7,6 +7,76 @@
>  .. kernel-doc:: drivers/gpu/drm/vkms/vkms_drv.c
>     :doc: vkms (Virtual Kernel Modesetting)
>  
> +Setup
> +=====
> +
> +The VKMS driver can be setup with the following steps:
> +
> +To check if VKMS is loaded, run::
> +
> +  lsmod | grep vkms
> +
> +This should list the VKMS driver. If no output is obtained, then
> +you need to enable and/or load the VKMS driver.
> +Ensure that the VKMS driver has been set as a loadable module in your
> +kernel config file. Do::
> +
> +  make nconfig
> +
> +  Go to `Device Drivers> Graphics support`
> +
> +  Enable `Virtual KMS (EXPERIMENTAL)`
> +
> +Compile and build the kernel for the changes to get reflected.
> +Now, to load the driver, use::
> +
> +  sudo modprobe vkms
> +
> +On running the lsmod command now, the VKMS driver will appear listed.
> +You can also observe the driver being loaded in the dmesg logs.
> +
> +To disable the driver, use ::
> +
> +  sudo modprobe -r vkms
> +
> +Testing With IGT
> +================
> +
> +The IGT GPU Tools is a test suite used specifically for debugging and
> +development of the DRM drivers.
> +The IGT Tools can be installed from
> +`here <https://gitlab.freedesktop.org/drm/igt-gpu-tools>`_ .
> +
> +The tests need to be run without a compositor, so you need to switch to text
> +only mode. You can do this by::
> +
> +  sudo systemctl isolate multi-user.target
> +
> +To return to graphical mode, do::
> +
> +  sudo systemctl isolate graphical.target
> +
> +Once you are in text only mode, you can run tests using the --device switch
> +or IGT_DEVICE variable to specify the device filter for the driver we want
> +to test. IGT_DEVICE can also be used with the run-test.sh script to run the
> +tests for a specific driver::
> +
> +  sudo ./build/tests/<name of test> --device "sys:/sys/devices/platform/vkms"
> +  sudo IGT_DEVICE="sys:/sys/devices/platform/vkms" ./build/tests/<name of test>
> +  sudo IGT_DEVICE="sys:/sys/devices/platform/vkms" ./scripts/run-tests.sh -t <name of test>
> +
> +For example, to test the functionality of the writeback library,
> +we can run the kms_writeback test::
> +
> +  sudo ./build/tests/kms_writeback --device "sys:/sys/devices/platform/vkms"
> +  sudo IGT_DEVICE="sys:/sys/devices/platform/vkms" ./build/tests/kms_writeback
> +  sudo IGT_DEVICE="sys:/sys/devices/platform/vkms" ./scripts/run-tests.sh -t kms_writeback
> +
> +You can also run subtests if you do not want to run the entire test::
> +
> +  sudo ./build/tests/kms_flip --run-subtest basic-plain-flip --device "sys:/sys/devices/platform/vkms"
> +  sudo IGT_DEVICE="sys:/sys/devices/platform/vkms" ./build/tests/kms_flip --run-subtest basic-plain-flip
> +
>  TODO
>  ====
>  
> -- 
> 2.25.1
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
