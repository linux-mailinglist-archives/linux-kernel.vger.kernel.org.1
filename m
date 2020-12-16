Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24AD12DBF32
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Dec 2020 12:07:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726089AbgLPLGy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Dec 2020 06:06:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725283AbgLPLGy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Dec 2020 06:06:54 -0500
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E902C061794
        for <linux-kernel@vger.kernel.org>; Wed, 16 Dec 2020 03:06:14 -0800 (PST)
Received: by mail-pg1-x52c.google.com with SMTP id w5so16626634pgj.3
        for <linux-kernel@vger.kernel.org>; Wed, 16 Dec 2020 03:06:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=JOOQpcp04fe7Ai/Scwmonj/jlQhNtKVes7u2TT8U0X4=;
        b=S/e3+RcHwRHNREai4eV3qePPu5aVF50Zv73xS38GVyJ01iu3wrbAQ5c791t/5IkcYM
         1WPdO8T0vOZqxG/6jTyKhnHhI2uOROTX3RiXlVB9SbQVUYH2gXbnBLABWzBmd+5ozCpZ
         yxT/GVm88oUEFKTpSUp9IVwXH5+3kepB5F+fYJ9ilSVWa7dDYXwEBdW96fWGC9XX9Muj
         CK36MiA+sqFVH3fEUnJ4Brul5Fn8uHNVDUhWFFJyUsUoNNm9yDI9gRoK1sttDIa116l5
         0pV9CICzrSs71tWCCUqmHKmFT6qM82MP9M4MxqnLKpbpZhqdJnzPySpObjgQg5rXk8W0
         KxPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=JOOQpcp04fe7Ai/Scwmonj/jlQhNtKVes7u2TT8U0X4=;
        b=MnIDZAQUnTI4tQc9fE958DM8LXVbkbg72yHEWNIh7+SjI/fCsOwBm/jztCtBisk8PB
         nQShulQpZzFaW1pyLxSTsHv7nMSc1ev/TAld79Ys416xiIVt/GiddxVxGz/lRxfcPy84
         y3upFLzrT/hDtTbb8oxdp1TJtt6NqfONlU+1q9pQvSJup9cwjDKHkYQj2nV9xaYXnr1C
         VBUn50t0DKurBeOhjg+qn/fXnCU1kRVDDtecNfZLBxIYYYxmQdXA+Xn6as/ZqA1fhhj6
         v0bMVyEy1zgitqUFcynjip810J6lE0KsYx3f47mnhskQ0LviDvGwOxrrNhHAJa7cdqjP
         Zvrw==
X-Gm-Message-State: AOAM5328bchona6nB3PVg9An3LWO080OcYOyLnlgDLDp+mmVxKXe+CtQ
        UABGEkp9smcAhP5U8p2VUwM=
X-Google-Smtp-Source: ABdhPJzgryV5EFyPEgVKa/Ym7NmyHZP5f5iQ8HNSLMTnXY9UjxcdOzvVstG7QN5HnbmPU2WH/SttAQ==
X-Received: by 2002:aa7:8d86:0:b029:19e:cb57:2849 with SMTP id i6-20020aa78d860000b029019ecb572849mr26379440pfr.54.1608116773633;
        Wed, 16 Dec 2020 03:06:13 -0800 (PST)
Received: from Asurada (c-73-162-191-63.hsd1.ca.comcast.net. [73.162.191.63])
        by smtp.gmail.com with ESMTPSA id fw12sm1729790pjb.43.2020.12.16.03.06.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 16 Dec 2020 03:06:13 -0800 (PST)
Date:   Wed, 16 Dec 2020 03:06:06 -0800
From:   Nicolin Chen <nicoleotsuka@gmail.com>
To:     Shengjiu Wang <shengjiu.wang@nxp.com>
Cc:     timur@kernel.org, Xiubo.Lee@gmail.com, festevam@gmail.com,
        broonie@kernel.org, perex@perex.cz, tiwai@suse.com,
        alsa-devel@alsa-project.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ASoC: imx-hdmi: Fix warning of the uninitialized
 variable ret
Message-ID: <20201216110605.GA2156@Asurada>
References: <1608115464-18710-1-git-send-email-shengjiu.wang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1608115464-18710-1-git-send-email-shengjiu.wang@nxp.com>
User-Agent: Mutt/1.5.22 (2013-10-16)
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

Acked-by: Nicolin Chen <nicoleotsuka@gmail.com>
