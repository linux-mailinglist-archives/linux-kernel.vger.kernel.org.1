Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B31881B51C3
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Apr 2020 03:21:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726157AbgDWBVS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Apr 2020 21:21:18 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:34145 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725854AbgDWBVR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Apr 2020 21:21:17 -0400
Received: by mail-pf1-f195.google.com with SMTP id x15so2098728pfa.1
        for <linux-kernel@vger.kernel.org>; Wed, 22 Apr 2020 18:21:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=HuA0hxQTe90PJtZs9WSSy8kDWUbxSlnvi9VsPza7S2Y=;
        b=NxRGnjG+UfX4tgyPXsBtpAS7Ie29rFncjOTE1gAkOH3z2STfgMKfNzV6wTRRmyuvfX
         zPB0hS7tuzb4UsOI8BNVUMKvlFqN5AlknjZeIFJCo6msYW9bLiO3Hd3mGQ/Vk9cSnQAW
         nFesuslAC/VQtY+yujN6O/0lKJF8WSZWoQ8nCIVqislChrJuS4Shql5nHK5/S6KWmraq
         MG371PT5+Ql5cHo3ZRVgAxO1u2aSPKJvkKaZ4yeju8Z/OfecVlBS9nHY2YiXxHGu5SnT
         sEI3IhylpUwVoljxW5svgPudgs2e+A4ImcQGEEFAGLAsjwIFFB0uTPBt2/39agzDHJ4O
         GP3Q==
X-Gm-Message-State: AGi0PuY3mPuDaXhI3aHXso6RXLG2DNZz8DJGHkF6jWUbvEvELXPHcrft
        X1hiWoCsb3uPZXuVtcSyWhA=
X-Google-Smtp-Source: APiQypKxBlGRT0F6vEFPhi5oneOUM697xMXU65q00ggKMra7UIbFqy/Kx++vjPJ34SrVHIxn8OpClA==
X-Received: by 2002:aa7:80cf:: with SMTP id a15mr1441540pfn.124.1587604876968;
        Wed, 22 Apr 2020 18:21:16 -0700 (PDT)
Received: from [100.124.12.67] ([104.129.198.222])
        by smtp.gmail.com with ESMTPSA id n23sm471545pjq.18.2020.04.22.18.21.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Apr 2020 18:21:16 -0700 (PDT)
Subject: Re: [PATCH v2] stacktrace: cleanup inconsistent variable type
To:     Walter Wu <walter-zh.wu@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        wsd_upstream <wsd_upstream@mediatek.com>
References: <20200421013511.5960-1-walter-zh.wu@mediatek.com>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <d2a9f155-f309-0182-73c9-5c02d7014574@acm.org>
Date:   Wed, 22 Apr 2020 18:21:13 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200421013511.5960-1-walter-zh.wu@mediatek.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/20/20 6:35 PM, Walter Wu wrote:
> Modify the variable type of 'skip' member of struct stack_trace.
> In theory, the 'skip' variable type should be unsigned int.
> There are two reasons:
> - The 'skip' only has two situation, 1)Positive value, 2)Zero
> - The 'skip' of struct stack_trace has inconsistent type with struct
>    stack_trace_data, it makes a bit confusion in the relationship between
>    struct stack_trace and stack_trace_data.

Reviewed-by: Bart Van Assche <bvanassche@acm.org>
