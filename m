Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DCEB02F3875
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jan 2021 19:22:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392135AbhALSUd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jan 2021 13:20:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391608AbhALSUc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jan 2021 13:20:32 -0500
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A361C061575
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jan 2021 10:19:52 -0800 (PST)
Received: by mail-qk1-x72f.google.com with SMTP id 22so2717133qkf.9
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jan 2021 10:19:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=6/4/dr7fn+zRTbNcUowmMs8Ol/J2eKhumjr3A4Q7PFg=;
        b=LynGEmqaTLG2T0txzoExer0ZVvjQ7ErcUJn8AJ46RHf/x34wtEtL7n7G5pZi3WcIkm
         2liRj0IBu3R/Tn5gyMpYhSPxmjvwY6kit3j+p+XB9kjWHJBvy87NuxGprIcmz7T4o+Pa
         ja9De+tLhO5ZymbHezPq6orUehBQJUjfP6yIJac6hT9UTC18Ywi00zftsU9YWd/crE+o
         BsH3yQICgUmTf3AHw/mNFffhDx8hkP7Mlux1H5J1fwO5BrBh/5oMSETzzv1jeDEN1Lpi
         w5gViEURf6IPAXIyznPwQsFVgMI7nur9g1x8FOe4lj8E8w59WZ3DCMqDSgfo4l5ea68X
         86Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=6/4/dr7fn+zRTbNcUowmMs8Ol/J2eKhumjr3A4Q7PFg=;
        b=bkZcqrv+47FIzj4yk8H+Uhfb5/+eZQIM9FgfjPdIt4I7/JSfaThnDvbpbju0mxwiGj
         PzSQCkRjK/czKFOw87DQ798N2qI9KnkZeS1pA1EZb1Sqv1gL8r3pl2QlZX0hDXmqBovp
         As2XG3YsN8INvYIg57cW6t5OkqQF+uy2MXgq9FA1GVNOAVCtcUhFmbtu8KksMyA25Qgy
         XhAM4WzVKFOI7qSYKF0nFivbunMhnKNUA6e/hnPswusKYKgzcrDDl0mJwpGJO3UAPRjn
         7BYHuSSUxQB17uv7bdAiuxq/AlAQ+zprXbfWevpy2QFu0iRb7RIClgHEuqCAnLQ6kXKx
         VroA==
X-Gm-Message-State: AOAM533+X8mlKVCjtUyvYmH9AKhIlmeMGDse6ACs8Za9Ku+whLZIZ6cv
        gN1uFTppToxlMAIFUUhRP/o=
X-Google-Smtp-Source: ABdhPJw0IfeM/ZZbNMvRUDF9MbEZALByeR0JUGlFVpnEJrx3y+U/PumG28kscAX3wbxVu5lB/HcYjQ==
X-Received: by 2002:a37:4f11:: with SMTP id d17mr615113qkb.53.1610475591791;
        Tue, 12 Jan 2021 10:19:51 -0800 (PST)
Received: from ubuntu-m3-large-x86 ([2604:1380:45f1:1d00::1])
        by smtp.gmail.com with ESMTPSA id q70sm1736569qka.107.2021.01.12.10.19.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Jan 2021 10:19:51 -0800 (PST)
Date:   Tue, 12 Jan 2021 11:19:49 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Shengjiu Wang <shengjiu.wang@nxp.com>
Cc:     timur@kernel.org, nicoleotsuka@gmail.com, Xiubo.Lee@gmail.com,
        festevam@gmail.com, broonie@kernel.org, perex@perex.cz,
        tiwai@suse.com, alsa-devel@alsa-project.org,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ASoC: imx-hdmi: Fix warning of the uninitialized
 variable ret
Message-ID: <20210112181949.GA3241630@ubuntu-m3-large-x86>
References: <1608115464-18710-1-git-send-email-shengjiu.wang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1608115464-18710-1-git-send-email-shengjiu.wang@nxp.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 16, 2020 at 06:44:24PM +0800, Shengjiu Wang wrote:
> From: shengjiu wang <shengjiu.wang@nxp.com>
> 
> When condition ((hdmi_out && hdmi_in) || (!hdmi_out && !hdmi_in))
> is true, then goto fail, the uninitialized variable ret will be
> returned.
> 
> Signed-off-by: shengjiu wang <shengjiu.wang@nxp.com>
> Reported-by: kernel test robot <lkp@intel.com>
> ---
>  sound/soc/fsl/imx-hdmi.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/sound/soc/fsl/imx-hdmi.c b/sound/soc/fsl/imx-hdmi.c
> index 2c2a76a71940..ede4a9ad1054 100644
> --- a/sound/soc/fsl/imx-hdmi.c
> +++ b/sound/soc/fsl/imx-hdmi.c
> @@ -164,6 +164,7 @@ static int imx_hdmi_probe(struct platform_device *pdev)
>  
>  	if ((hdmi_out && hdmi_in) || (!hdmi_out && !hdmi_in)) {
>  		dev_err(&pdev->dev, "Invalid HDMI DAI link\n");
> +		ret = -EINVAL;
>  		goto fail;
>  	}
>  
> -- 
> 2.17.1
> 

I still see a warning in v5.11-rc3 that is fixed by this patch, is it
not going in this release cycle? It is a regression fix, seems like it
should.

Cheers,
Nathan
