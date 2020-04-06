Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 214471A0135
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Apr 2020 00:43:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726331AbgDFWnw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Apr 2020 18:43:52 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:44686 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725933AbgDFWnv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Apr 2020 18:43:51 -0400
Received: by mail-pl1-f194.google.com with SMTP id h11so442038plr.11;
        Mon, 06 Apr 2020 15:43:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=TU6zRlp6bLsLQvuU0UNh0Rjs9SMeCJnn8DHzXq3NahA=;
        b=kLJPEGqkkgLnVbzA/I1nZdwcgddzzL+2wXZ5Xp1wnWMMVjFPOf3YQaOQy8TL1M0v26
         3zVTMY9m62NSg/FwiRYeADQhn6OD90JCaiQOoLGTOSfHSyRH98rGuTU4k3wUihHLgnoM
         3slUwXsnIbL3ONy473/bh2JtTR12Aj8f9DfVhCGwBDD35ya2UJbjieo3M0XuSZONcaLe
         4NTBLpfwm38kvCsf9/fDWgJlbf9SsZEMzZfQdD7zeT5JZ+/AmrdHAqboOvL2/ycAgkdx
         OmtkjNNiJAORPFexNi771zvXl40gfTZ8znTbAE9+pChnRuB1o2OtQonZU9tDWIsYHnrx
         lLHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=TU6zRlp6bLsLQvuU0UNh0Rjs9SMeCJnn8DHzXq3NahA=;
        b=CUMScXTtECcwzFqj+qhQAhHmnS/GTMXhnh43FJ7Vo5VaWChOQczx4cib6JDnOHMWZp
         33GngKgQZrWAMZRuE8QdNBdxzEimyUn2JPStbVWPrqyo8FfziqytnivIZmTXcHdkpTiz
         PNQHKZcsEVfHa42HMK9YVq+kXCgr/OjeoDnd9CQKNWFdNwZe28h+sifK5feuHPxDorXy
         w7jlRbwYgZ/4O9SSFNZG32ccBAw4eEhRIank87lamU6SUU6+QK4eIO+LB+ynr8czohHA
         Mhg0MdTmYCmVVxo5Rl69TlBTbMlTdYZfU1f3JWf7ooVjThjX4j4yegFuzeHgD92/C+yB
         r6gg==
X-Gm-Message-State: AGi0PuZq7EOqaBHEBy53TI38bwC+9Rygy7WSLCZzp8t8uwUfON731zC6
        w9Njx9nvhmXjY5vtiRfC7bc=
X-Google-Smtp-Source: APiQypLOSynrL78ItHLA268DR9LFHq6YzYF0pLnuY2yHwnMr2DJQM0F4Xmt3tudbtp848HtDy2ffOQ==
X-Received: by 2002:a17:90a:1911:: with SMTP id 17mr1755900pjg.65.1586213030402;
        Mon, 06 Apr 2020 15:43:50 -0700 (PDT)
Received: from Asurada-Nvidia.nvidia.com (thunderhill.nvidia.com. [216.228.112.22])
        by smtp.gmail.com with ESMTPSA id l7sm12590717pfl.171.2020.04.06.15.43.49
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 06 Apr 2020 15:43:50 -0700 (PDT)
Date:   Mon, 6 Apr 2020 15:43:52 -0700
From:   Nicolin Chen <nicoleotsuka@gmail.com>
To:     Shengjiu Wang <shengjiu.wang@nxp.com>
Cc:     timur@kernel.org, Xiubo.Lee@gmail.com, festevam@gmail.com,
        broonie@kernel.org, alsa-devel@alsa-project.org,
        lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com,
        robh+dt@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 2/7] ASoC: dt-bindings: fsl_asrc: Add new property
 fsl,asrc-format
Message-ID: <20200406224352.GA20891@Asurada-Nvidia.nvidia.com>
References: <cover.1585726761.git.shengjiu.wang@nxp.com>
 <47fcf06689d1a086141ce4d80f7ea7af7958dc89.1585726761.git.shengjiu.wang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <47fcf06689d1a086141ce4d80f7ea7af7958dc89.1585726761.git.shengjiu.wang@nxp.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 01, 2020 at 04:45:35PM +0800, Shengjiu Wang wrote:
> In order to support new EASRC and simplify the code structure,
> We decide to share the common structure between them. This bring
> a problem that EASRC accept format directly from devicetree, but
> ASRC accept width from devicetree.
> 
> In order to align with new ESARC, we add new property fsl,asrc-format.
> The fsl,asrc-format can replace the fsl,asrc-width, then driver
> can accept format from devicetree, don't need to convert it to
> format through width.
> 
> Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>

Once Rob has no objection:
Acked-by: Nicolin Chen <nicoleotsuka@gmail.com>

> ---
>  Documentation/devicetree/bindings/sound/fsl,asrc.txt | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/sound/fsl,asrc.txt b/Documentation/devicetree/bindings/sound/fsl,asrc.txt
> index cb9a25165503..998b4c8a7f78 100644
> --- a/Documentation/devicetree/bindings/sound/fsl,asrc.txt
> +++ b/Documentation/devicetree/bindings/sound/fsl,asrc.txt
> @@ -51,6 +51,10 @@ Optional properties:
>  			  will be in use as default. Otherwise, the big endian
>  			  mode will be in use for all the device registers.
>  
> +   - fsl,asrc-format	: Defines a mutual sample format used by DPCM Back
> +			  Ends, which can replace the fsl,asrc-width.
> +			  The value is 2 (S16_LE), or 6 (S24_LE).
> +
>  Example:
>  
>  asrc: asrc@2034000 {
> -- 
> 2.21.0
> 
