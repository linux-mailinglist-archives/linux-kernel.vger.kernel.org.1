Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8BD1D29A94B
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Oct 2020 11:15:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2897641AbgJ0KPQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Oct 2020 06:15:16 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:37147 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2896717AbgJ0KPP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Oct 2020 06:15:15 -0400
Received: by mail-wm1-f68.google.com with SMTP id c16so822542wmd.2
        for <linux-kernel@vger.kernel.org>; Tue, 27 Oct 2020 03:15:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=gHiAbcgUE6039vCDjb8dA4GzP14VCVY9EpZixtfiLYA=;
        b=hF0nkXcK9hgwePiKRPR8lfCQQ3GDIFiVcGa5WS/JIHKu+QjGTC3ryFPWczqEykk485
         WYecgDpgggPvrf2tFeVcEcFWGYd1YKjRGryFoMiTHv5sQOt0zo69iwdQrc8weHxrT2vh
         JDtgUbngN67y/urWQP9WFl9+J0AH0/QLIgCxGkwbNG5EgMMJ1HeuOhfJLKxUoCcA7Qyh
         DKdfsmva1qSvwD8xqaxA8rIY8lvHQTkbyC0bM6NANACVG+poexLANiE2aRInOLedPK6U
         sG265ZGb7175ocXDJ0RD3PrF8Np4DsBjwmXcbUEKsF2fiB0q3KlIymxEO8TSgev0HXbd
         u5UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=gHiAbcgUE6039vCDjb8dA4GzP14VCVY9EpZixtfiLYA=;
        b=IyeCmXef0vIrhABwmRvjdjl2e51FrlqUx2SH9kO4GiDvoWrZ61XaUeH7Y7nh24xtKe
         ozStNddU4hO4NmJhaIzUq556Ivnfvv+EbGLTc35SJwmC/bwQ+nZrtRIeQYSNIBi+cLDG
         tvmIUmOVgVPqodZS6Hfre2J6kDK5ft7zJh7qLvb0l/p1x3mTAZ0QBjyO7JMG/5QLuHZ0
         gITJ2Y+I5fia3oPPIdr0J35zTF7/bI77PJlqmpS7KkC9nasRrhP1pe9aqzkgtORloAXn
         +INLpMOFD/VrEuIUr/R/qq1YKXovL7vYMqI6Ihmwk71sNqoC6eaazz/ADh3/w0B/EA2L
         YCvQ==
X-Gm-Message-State: AOAM531fsBeDn225G2+wjlGXDErKPEjME2NBv/KBPJvPwoYCPZ46ApJg
        N2znREv1gPzp7sJSiEaoLjy7hg==
X-Google-Smtp-Source: ABdhPJzOrub0E7lKqKJqaFVDcABkhPY6UcydqrUPMcLUDHdwe+LMUeAB/DCNI1LTayaR+q/l3L1fww==
X-Received: by 2002:a7b:cb46:: with SMTP id v6mr1876088wmj.146.1603793713699;
        Tue, 27 Oct 2020 03:15:13 -0700 (PDT)
Received: from [192.168.86.34] (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
        by smtp.googlemail.com with ESMTPSA id g14sm1382122wrx.22.2020.10.27.03.15.12
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 27 Oct 2020 03:15:12 -0700 (PDT)
Subject: Re: [PATCH v1 3/6] ASoC: codecs: lpass-wsa-macro: add dapm widgets
 and route
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        broonie@kernel.org
Cc:     alsa-devel@alsa-project.org, plai@codeaurora.org,
        lgirdwood@gmail.com, linux-kernel@vger.kernel.org,
        spapothi@codeaurora.org
References: <20201026141945.19707-1-srinivas.kandagatla@linaro.org>
 <20201026141945.19707-4-srinivas.kandagatla@linaro.org>
 <98d3f89b-8d71-e652-504b-2bb770532a09@linux.intel.com>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <b6ffdcf6-4f3a-f8be-422a-4de2d304fe5f@linaro.org>
Date:   Tue, 27 Oct 2020 10:15:11 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <98d3f89b-8d71-e652-504b-2bb770532a09@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks Pierre for review on all the patches.

On 26/10/2020 19:58, Pierre-Louis Bossart wrote:
> Run cppcheck on this sort of code:
> 
> cppcheck --platform=unix32 --force --max-configs=1024 --inconclusive
> --enable=all --suppress=variableScope sound/soc/codecs/lpass-wsa-macro.c

I normally do sparse checks before sending patches, which did not catch 
these.

thanks for the suggestion, I will keep add these checks to my future 
patches.

And w.r.t comments, I agree with all the changes and will send v2 with 
those fixed!

thanks,
srini
