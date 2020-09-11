Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0880265AE5
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Sep 2020 09:54:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725793AbgIKHyy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Sep 2020 03:54:54 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:35958 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725554AbgIKHyo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Sep 2020 03:54:44 -0400
Received: by mail-ed1-f67.google.com with SMTP id w1so9042503edr.3
        for <linux-kernel@vger.kernel.org>; Fri, 11 Sep 2020 00:54:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=0I/ZdGkuIr3JoP7rRmJ+zxyQ7oEKoTVS9yur/NkoIf0=;
        b=XCpd6c6wvB21N4iEWrPlinEy2i0ydrccsWkCDTc/Gv90ApogN+Dy9EgPWOS/JklTmJ
         2UxGkUkklpHMy2lR498rQfSOvLg4ndLFQi/F4d3EOPPJcVXgzZ+1j4MZgHuhB0FUk1nM
         blzo5hYACFXGuzGOU3UZO1SvAZ12tclSw+WaqhcSN7T7VtEn6/Pe0Cs5zq3Th2Vu8rC4
         YoM744U6xL1Z4ZUei6F6rjcoj+xsSfQcOF7nSDNuCFqVQQhUGri6dfn7s920c3o4NHVp
         GHsPrgLOo8FQYaHsxqCRyn8E5+ywJ5op9zsHAUnSOf5wKH/nU/ZX/B1L8R9HSwdPX5E3
         G9jg==
X-Gm-Message-State: AOAM532uGktptvZqvJ/nFG0ebZAtM7qOpnXfAfd7eOsJqvmbAhHxNqoz
        PLhzWwsDJBsQUiskKgFBlys=
X-Google-Smtp-Source: ABdhPJzRtQ0X94H2fDvUJZrcp+Dm9AfI6lguQAi5pLjGbvPo4Kyp8wvCKu96XByy4lPTumbGN5/T0Q==
X-Received: by 2002:a50:d4ce:: with SMTP id e14mr776330edj.126.1599810881793;
        Fri, 11 Sep 2020 00:54:41 -0700 (PDT)
Received: from kozik-lap ([194.230.155.174])
        by smtp.googlemail.com with ESMTPSA id i7sm1031530ejo.22.2020.09.11.00.54.40
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 11 Sep 2020 00:54:40 -0700 (PDT)
Date:   Fri, 11 Sep 2020 09:54:39 +0200
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Chanwoo Choi <cw00.choi@samsung.com>
Cc:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Vijai Kumar K <vijaikumar.kanagarajan@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] extcon: ptn5150: Use defines for registers
Message-ID: <20200911075439.GA11145@kozik-lap>
References: <CGME20200909172007epcas1p2fe01380c62ca112a19283f2dc63e75f9@epcas1p2.samsung.com>
 <20200909150129.12476-1-krzk@kernel.org>
 <7571e535-f0ff-2371-1669-734c3996aacf@samsung.com>
 <20200911053805.GA2954@kozik-lap>
 <6e621023-530a-727c-fff7-e8435ca4a4d2@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <6e621023-530a-727c-fff7-e8435ca4a4d2@samsung.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 11, 2020 at 05:03:02PM +0900, Chanwoo Choi wrote:
> On 9/11/20 2:38 PM, Krzysztof Kozlowski wrote:
> > On Fri, Sep 11, 2020 at 12:14:19PM +0900, Chanwoo Choi wrote:
> >> On 9/10/20 12:01 AM, Krzysztof Kozlowski wrote:
> >>> The register addresses are not continuous, so use simple defines for
> >>> them.  This also makes it easier to find the address for register.
> >>>
> >>> No functional change.
> >>>
> >>> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> >>> ---
> >>>  drivers/extcon/extcon-ptn5150.c | 22 ++++++++++------------
> >>>  1 file changed, 10 insertions(+), 12 deletions(-)
> >>>
> >>> diff --git a/drivers/extcon/extcon-ptn5150.c b/drivers/extcon/extcon-ptn5150.c
> >>> index dda5b3a3a908..1b68f56d8372 100644
> >>> --- a/drivers/extcon/extcon-ptn5150.c
> >>> +++ b/drivers/extcon/extcon-ptn5150.c
> >>> @@ -19,18 +19,16 @@
> >>>  #include <linux/gpio/consumer.h>
> >>>  
> >>>  /* PTN5150 registers */
> >>> -enum ptn5150_reg {
> >>> -	PTN5150_REG_DEVICE_ID = 0x01,
> >>> -	PTN5150_REG_CONTROL,
> >>> -	PTN5150_REG_INT_STATUS,
> >>> -	PTN5150_REG_CC_STATUS,
> >>> -	PTN5150_REG_CON_DET = 0x09,
> >>> -	PTN5150_REG_VCONN_STATUS,
> >>> -	PTN5150_REG_RESET,
> >>> -	PTN5150_REG_INT_MASK = 0x18,
> >>> -	PTN5150_REG_INT_REG_STATUS,
> >>> -	PTN5150_REG_END,
> >>> -};
> >>> +#define PTN5150_REG_DEVICE_ID			0x01
> >>> +#define PTN5150_REG_CONTROL			0x02
> >>> +#define PTN5150_REG_INT_STATUS			0x03
> >>> +#define PTN5150_REG_CC_STATUS			0x04
> >>> +#define PTN5150_REG_CON_DET			0x09
> >>> +#define PTN5150_REG_VCONN_STATUS		0x0a
> >>> +#define PTN5150_REG_RESET			0x0b
> >>> +#define PTN5150_REG_INT_MASK			0x18
> >>> +#define PTN5150_REG_INT_REG_STATUS		0x19
> >>> +#define PTN5150_REG_END				PTN5150_REG_INT_REG_STATUS
> >>
> >> PTN5150_REG_END should be (PTN5150_REG_INT_REG_STATUS + 1)
> >> for regmap operation of PTN5150_REG_INT_REG_STATUS.
> > 
> > Why? This goes to regmap's max_register which is the last register
> > allowed to read:
> > 
> >   drivers/base/regmap/regmap-debugfs.c:   for (i = 0; i <= map->max_register; i += map->reg_stride) {
> >   drivers/base/regmap/regmap.c:   if (map->max_register && reg > map->max_register)
> 
> It is my mismake. You're right.
> Applied them. Thanks.

Great, thank you!

Best regards,
Krzysztof

