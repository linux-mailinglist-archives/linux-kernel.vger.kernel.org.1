Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57FC521C908
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Jul 2020 13:22:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728888AbgGLLWP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Jul 2020 07:22:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728851AbgGLLWO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Jul 2020 07:22:14 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86FB3C08C5DD
        for <linux-kernel@vger.kernel.org>; Sun, 12 Jul 2020 04:22:14 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id k18so9638833qke.4
        for <linux-kernel@vger.kernel.org>; Sun, 12 Jul 2020 04:22:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=landley-net.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=E8uIIGdZhBbt4P5nnZk6uO1gBzr10gvYnt0IgsMFtwA=;
        b=iDNr7lScSy5HSPnOIvGjT67vtn/XV/mjkEMKKL9E+H+Sokl1bQU7aUHIXX/MWVY3jg
         nNVrzTs7NVEFiNEt1QE45o9yOzxHr/CD9VbXiZDMYDMbCVIl66/VGhwot2HmJ6V5IOQo
         wE9kY9jsu9gMIenWCc4Jf9InVdIxwpKQue8q1MMxrJn5evdxNHTLXH1yJA8y6tpmlyBD
         bICbKgfL2ou6wrIVzODfEoxlLGqVhzx0xZh1yFMYIhhhsPMLlCMr0VuNYhkRaQw9coid
         al5MOsPTf9ZMUJZ99HfoShOVJhs9OOY9zJKwgA5lsaxnLgrZuG8IbiAH3+zWH0hAqOR4
         7BJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=E8uIIGdZhBbt4P5nnZk6uO1gBzr10gvYnt0IgsMFtwA=;
        b=FaVLN1riu+W4T9XoQFdbkqzNiUyzKOsfoPjnznM/RTy7O3QY9dOoyQW+oAXfgm3cHe
         RosEtxcMnKYg5NX+p9qCQBEGj9m+1eQtDaB9QRp2Y/JUS6OA7iW012SkhA9eFER1KSN+
         xFIzYMEV8sTtRjcnI289BI5UF2OFTXRrIhHS9F+5X6O9U6p0g0aTOkqA8hI8obcjq/Bp
         HDFVYwUnkupZnEvwM+MmLV/isb7j6L3U7a+rqfWzbDlL6n3/9GpJ+bZIGoU3KQD3K31C
         ycUrnhKWKe7NrXHyR/in2BFZtGEVaxqcmWsOAEi0wKfysOG1T2Rj4Zgk3PTIqSzJZpIc
         E8fw==
X-Gm-Message-State: AOAM530Qsnpp+D0VvPBXRlZZ55WXO1aUNdeDW6h3wUt13jYaEpS9yUNe
        KPyz6wQ72j2YxnHhuvfLIA4mXmtTDLdFcA==
X-Google-Smtp-Source: ABdhPJwXIX/5PdSBHlaLzL5ZpjQeaRL0vF/bU9bzDwuxMCHJrW33wRDReDTH1nuTtATOSSmmX1BSSg==
X-Received: by 2002:a37:451:: with SMTP id 78mr49538711qke.117.1594552933707;
        Sun, 12 Jul 2020 04:22:13 -0700 (PDT)
Received: from ?IPv6:2607:fb90:95b7:945a:fceb:31ff:fed3:9377? ([2607:fb90:95b7:945a:fceb:31ff:fed3:9377])
        by smtp.gmail.com with ESMTPSA id g1sm16012505qkl.86.2020.07.12.04.22.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 12 Jul 2020 04:22:12 -0700 (PDT)
Subject: Re: [PATCH] sh: Replace HTTP links with HTTPS ones
To:     "Alexander A. Klimov" <grandmaster@al2klimov.de>,
        ysato@users.sourceforge.jp, dalias@libc.org,
        linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org
References: <8b008a69-e73a-43cc-3dba-c1bce90c9902@landley.net>
 <20200712111118.24916-1-grandmaster@al2klimov.de>
From:   Rob Landley <rob@landley.net>
Message-ID: <14fdab51-0197-1784-9ebb-356a0fd39952@landley.net>
Date:   Sun, 12 Jul 2020 06:30:04 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200712111118.24916-1-grandmaster@al2klimov.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/12/20 6:11 AM, Alexander A. Klimov wrote:
> Rationale:
> Reduces attack surface on kernel devs opening the links for MITM
> as HTTPS traffic is much harder to manipulate.

Trimmed just to the one site without the self-signed certficate: check.

> Deterministic algorithm:
> For each file:
>   If not .svg:
>     For each line:
>       If doesn't contain `\bxmlns\b`:
>         For each link, `\bhttp://[^# \t\r\n]*(?:\w|/)`:
> 	  If neither `\bgnu\.org/license`, nor `\bmozilla\.org/MPL\b`:
>             If both the HTTP and HTTPS versions
>             return 200 OK and serve the same content:
>               Replace HTTP with HTTPS.
> 
> Signed-off-by: Alexander A. Klimov <grandmaster@al2klimov.de>

Acked-by: Rob Landley <rob@landley.net>

Rob
