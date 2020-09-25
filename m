Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E68CD279210
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Sep 2020 22:33:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729013AbgIYUd2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Sep 2020 16:33:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727286AbgIYUWM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Sep 2020 16:22:12 -0400
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com [IPv6:2607:f8b0:4864:20::f35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9EBFC05BD0B;
        Fri, 25 Sep 2020 13:20:29 -0700 (PDT)
Received: by mail-qv1-xf35.google.com with SMTP id cv8so2037189qvb.12;
        Fri, 25 Sep 2020 13:20:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:date:from:to:cc:message-id:in-reply-to:references;
        bh=LUHm00ZIJ4j/6Y7/pu4Dj8elDY57oj54PB0d9vo74fk=;
        b=rVHeNYw6ax44V3kWWPVeu00y7iEOtaGrpyVj2tXAox6Y9+/sU28lxZfFyTgyeb35OB
         0CbHo3jYypqge3AO+2xjSxf4D84kW3kNQ+PpzrPVZECtxkDM0RrLeHoz9/2+qdUvloo1
         l2h0P2ZJELNk/IprcOiN6ETDq5KsoYWvgG6trZ+yjX6xqPeWrNQJbM2k/FfJRbSxfAgw
         wH8NYx44qwSevLP50P1qC/oDW/bqFLCU+K+HBm5zOjkT0D/LRdePeHvEu87pEzR4yuER
         L4oWifpJa+h+2sQyCDf5YWtAf2FupLgR64tBURwp75asDm2jiSWE5JlRFOAHejC9aB2R
         zbpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:date:from:to:cc:message-id:in-reply-to
         :references;
        bh=LUHm00ZIJ4j/6Y7/pu4Dj8elDY57oj54PB0d9vo74fk=;
        b=ZP8wXh4oPx8aqBHGfV8d+6oGfFcggyCEudaaQ2sJ1YxfkO+sqt8uWeHYlu/uCCTdJX
         wMyIvUppP0K2gaaQTBiI5L5SCoY1w8Ms21yRL5MoaoN/B6bzFaq0UnQZPfNl49rzF0OE
         iHilkW539UTylzqkXgDhSvnq8wnnxX1S7MfwReKZVHxWiiogzYrolZaPDyRssrDECKQ6
         RAT3QwGSVoBMWG1ud5+/L8H3Kvt0aLvcmsezYWsK9XDc1azviMSQdZ67CHkb2tQPwPg2
         bGp5kfj03lqmGAM1Q85cSao2TgTABIWEqK+/S1OsTPEOkjVawPxf9KmCbq/w0/zd7V+u
         qFEA==
X-Gm-Message-State: AOAM531uUwfIvpe0MAW5x7z506o7ZuCaPm+ReiP6J26N8jsq0tyzgtZw
        OdPasNdHihSdJxwmwFyuIhtX4Xx2R6/V2Q==
X-Google-Smtp-Source: ABdhPJyuIgJBVjQG0Q3pdpKZLjNMr4Maqp/uvudQU++Wiwm7OzMd3yWUfeEsMBMlwuuaVFxvwDu3iw==
X-Received: by 2002:a0c:b343:: with SMTP id a3mr339082qvf.41.1601065229122;
        Fri, 25 Sep 2020 13:20:29 -0700 (PDT)
Received: from gmail.com (chomsky.torservers.net. [77.247.181.162])
        by smtp.gmail.com with ESMTPSA id v16sm2347837qkg.37.2020.09.25.13.20.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Sep 2020 13:20:28 -0700 (PDT)
Subject: Re: [RFC] openprom: Fix 'opiocnextprop'; ensure integer conversions; use string size
Date:   Fri, 25 Sep 2020 20:20:20 -0000
From:   Michael Witten <mfwitten@gmail.com>
To:     David Miller <davem@davemloft.net>
Cc:     sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org
Message-ID: <859f327c79da4d9c945e50568805456c@gmail.com>
In-Reply-To: <20200914.170321.1710628974878239639.davem@davemloft.net>
References: <a5515efeaad94666a87f264dbf65bdbd@gmail.com>
  <20200914.170321.1710628974878239639.davem@davemloft.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: David Miller <davem@davemloft.net>
Date: Mon, 14 Sep 2020 17:03:21 -0700

> From: Michael Witten <mfwitten@gmail.com>
> Date: Fri, 04 Sep 2020 19:40:00 -0000
>
>> @@ -34,10 +34,10 @@ EXPORT_SYMBOL(of_console_options);
>>  int of_getintprop_default(struct device_node *np, const char *name, int def)
>>  {
>>       struct property *prop;
>> -     int len;
>> +     int size;
>> 
>> -     prop = of_find_property(np, name, &len);
>> -     if (!prop || len != 4)
>> +     prop = of_find_property(np, name, &size);
>> +     if (!prop || size != 4)
>>               return def;
>
> This is just changing the variable name and makes no functional change
> at all, and therefore is gratuitous.
>
> Please only include pure functional changes that fix the bug(s) in
> question.
>
> [...]

There's a reason the variable is named "size" (or even "len") rather than:

  v75127e6344

A name is functional; it is the only way we have to structure a [human]
reader's conceptual understanding of what's going on.

The name "len" is a poor choice; it added to my uncertainty when I began
trying to understand the code in question.

As explained in the commit message:

  | String Size
  | ===========
  |
  | There is an important distinction to be made between the following:
  |
  |   * A nul-terminated string's size
  |   * A nul-terminated string's length
  |
  | This commit tries to make this distinction as much as possible,
  | and assumes that all strings are intended to be nul-terminated.
  | The result is the following:
  |
  |   * Sometimes a variable's name is simply changed (e.g., from
  |     'len' to 'size').
  |
  |   * Sometimes 'strlen()' is called rather than relying on
  |     some buffer size.
  |
  |   * Sometimes, there is the replacement of code that erroneously
  |     uses string length rather than string size.
  |
  | All together, these changes make the code more robust and correct.

Are we trying to improve the code or not?

Also, this name change is like a surgeon removing a benign anomaly
while the abdomen is open for some other purpose; it's strategic,
not "gratuitous".

Sincerely,
Michael Witten
