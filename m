Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55F3E2927B5
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Oct 2020 14:55:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727270AbgJSMzh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Oct 2020 08:55:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:46958 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726336AbgJSMzh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Oct 2020 08:55:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1603112135;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ticZMXdjFyuhy7AlqQJ6aW1BCbz8bmeqkMyCMuPVBrQ=;
        b=g+MOJIA4H1ahTv14ks8ZehSUdr7w3TQKF8+/oVOVzz9gakazCni0XFPnYsltVmiQoHvfpX
        p3S89hp8HcYFZOSvXazY31U/+SlnIyb2XSzAIFpT5USyDCdKYGafPeZ9Vkcdw+rPMKewUo
        6enafYwMXaqWKGkqOb4V9HSIWWhDxF8=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-591-XrYC_mLBPiite6eTAKzQtg-1; Mon, 19 Oct 2020 08:55:34 -0400
X-MC-Unique: XrYC_mLBPiite6eTAKzQtg-1
Received: by mail-qt1-f198.google.com with SMTP id h31so6113010qtd.14
        for <linux-kernel@vger.kernel.org>; Mon, 19 Oct 2020 05:55:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=ticZMXdjFyuhy7AlqQJ6aW1BCbz8bmeqkMyCMuPVBrQ=;
        b=cDTGt1YDuEAYdQCw65AXcgsc5fdtFX9WSVe9tUPA9Fr8Pao8LoCby8lkwED/i8CPxX
         RyeJJkWnievdrkylo2rvuAr+9DvNYe83OVclnDAfFHb8gEpPcwoMtpS4nGuauwOshCt7
         ZnViDhdh0DTPbEOxYN14NLGVzrNKeaqoXuyRMDWPW0h4nrWQpiCmvzN/69ClN7+0PjPy
         NKSk7aCzvu3XOc02ZXWQOqurRs8xo21q2HNcuAXNL7ZGWQLbbKS+wyeuvjx0/cobNj4B
         D1BSjf0MqB1CODRBLDK3gcrfZssd3Oq1A6MQE/SzczwemuX63SrBehojL7X7VXMTj1Kz
         ocwg==
X-Gm-Message-State: AOAM531+QbzvsmcxUo5RmL30YYkSPUzDL4gzk3ycuWMqtxUxtIJAopgP
        mJUd/yVmpyd46Cv/3a5gFuYN8O5iAQ+N5fTlIcdUtvqNgO9CKiiN8JoJe0AsE+tpSIaUuindelG
        /S7W0qFGM/B6GBN9Nr/1MVqqI
X-Received: by 2002:ac8:6ec7:: with SMTP id f7mr14275226qtv.45.1603112133309;
        Mon, 19 Oct 2020 05:55:33 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzxLA2eF0bNDpUfMI2wAfc8LZq4aaTUjKQgRbAsiAJUaZNudtOj8D0MCnF/brfSxzHb1cBOiA==
X-Received: by 2002:ac8:6ec7:: with SMTP id f7mr14275204qtv.45.1603112133039;
        Mon, 19 Oct 2020 05:55:33 -0700 (PDT)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id z69sm4136661qkb.7.2020.10.19.05.55.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Oct 2020 05:55:32 -0700 (PDT)
Subject: Re: [PATCH] checkpatch: Allow --fix removal of unnecessary break
 statements
To:     Joe Perches <joe@perches.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Julia Lawall <julia.lawall@inria.fr>, linux-kernel@vger.kernel.org,
        cocci <cocci@systeme.lip6.fr>
References: <20201017160928.12698-1-trix@redhat.com>
 <f530b7aeecbbf9654b4540cfa20023a4c2a11889.camel@perches.com>
 <alpine.DEB.2.22.394.2010172016370.9440@hadrien>
 <dfe24da760056e31d90ff639b47c494263b5f4a7.camel@perches.com>
 <a15ada1f-9bad-612e-e841-934bff088f38@redhat.com>
 <49c87dede8d06ba90ecb3200b2a773860d61a3c8.camel@perches.com>
From:   Tom Rix <trix@redhat.com>
Message-ID: <c02aed9b-ab6c-1054-1e8a-4006f2a75f94@redhat.com>
Date:   Mon, 19 Oct 2020 05:55:30 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <49c87dede8d06ba90ecb3200b2a773860d61a3c8.camel@perches.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 10/18/20 1:19 PM, Joe Perches wrote:
> On Sun, 2020-10-18 at 13:07 -0700, Tom Rix wrote:
>> I like!
> []
>> could add a '|break' here to catch the couple
> []
>> break;
>>
>> break;
> Unfortunately, checkpatch is really stupid and it
> wouldn't catch those
> cases as there are blank lines
> between the existing consecutive break
> statements.
>
> It would catch
>
> 	break;
> 	break;
>
> but there aren't any of those so it seems unlikely
> to be a very useful addition.

Unusual, but there are a couple of these.

Here's one from my rfc diff

diff --git a/sound/soc/codecs/wcd-clsh-v2.c b/sound/soc/codecs/wcd-clsh-v2.c
index 1be82113c59a..817d8259758c 100644
--- a/sound/soc/codecs/wcd-clsh-v2.c
+++ b/sound/soc/codecs/wcd-clsh-v2.c
@@ -478,11 +478,10 @@ static int _wcd_clsh_ctrl_set_state(struct wcd_clsh_ctrl *ctrl, int req_state,
         wcd_clsh_state_hph_l(ctrl, req_state, is_enable, mode);
         break;
     case WCD_CLSH_STATE_HPHR:
         wcd_clsh_state_hph_r(ctrl, req_state, is_enable, mode);
         break;
-        break;
     case WCD_CLSH_STATE_LO:
         wcd_clsh_state_lo(ctrl, req_state, is_enable, mode);
         break;
     default:
         break;

Tom

>

