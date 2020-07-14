Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8CF1B21E583
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jul 2020 04:15:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726763AbgGNCPq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jul 2020 22:15:46 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:34021 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726364AbgGNCPq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jul 2020 22:15:46 -0400
Received: by mail-io1-f68.google.com with SMTP id q74so15744587iod.1;
        Mon, 13 Jul 2020 19:15:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=W/3EJR0UO+DEw9NNDm9c2vVCgxBKwyW6tiiCML3eaIY=;
        b=h9F/+XOE0BmO28e+aRe0ajTH2K6YGjVmJ7Ao8U+3iBmTC5As9LTuLhvX/wA0VoLNmn
         JX6LPhdxQPmw7snW/6VMtMucrBV5z5qN9TIyZt7YMTMkukzad+pdr3H9P6u+0HThFCHF
         45Nl/oE6GMno10UuOpBN0CRQO9PH4gtH54Czjwo6DrM/vow8KQvBgSQB1qzt0md2MhqT
         VrmsgzilTbGWXWT78OSPnpzZpbTLUf82muZo3ahFq03TFPeNnAL1JeOvHflO9CMpvwoB
         MtDEzTpIDTNyqfKqjrZpCHtxIfbJB/smuN90pD9WeRK2lHCDoUvlxUDLFalenpFIyrwo
         bQOA==
X-Gm-Message-State: AOAM53273Pow+fHlSlx4b4TZYTXMCp+q8my0rkmED0puV7JGBFnUbrwj
        2XTSNjsvtWxXUGOdfEt9xg==
X-Google-Smtp-Source: ABdhPJzlc8uQiBvXN6TzU1Q5aKmi07q/eB5wKID1pG8ixxrevptiDKxWRy7HG9xU/9WbA9zAZ1U+jA==
X-Received: by 2002:a02:cf12:: with SMTP id q18mr3366899jar.3.1594692945604;
        Mon, 13 Jul 2020 19:15:45 -0700 (PDT)
Received: from xps15 ([64.188.179.252])
        by smtp.gmail.com with ESMTPSA id u5sm9573480ili.33.2020.07.13.19.15.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2020 19:15:45 -0700 (PDT)
Received: (nullmailer pid 1141630 invoked by uid 1000);
        Tue, 14 Jul 2020 02:15:44 -0000
Date:   Mon, 13 Jul 2020 20:15:44 -0600
From:   Rob Herring <robh@kernel.org>
To:     Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>
Cc:     James Tai =?utf-8?B?W+aItOW/l+WzsF0=?= <james.tai@realtek.com>,
        Stanley Chang =?utf-8?B?W+aYjOiCsuW+t10=?= 
        <stanley_chang@realtek.com>, linux-arm-kernel@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>,
        linux-realtek-soc@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Edgar Lee <cylee12@realtek.com>
Subject: Re: [PATCH v2 24/29] dt-bindings: soc: realtek: rtd1195-chip: Allow
 nvmem-cells property
Message-ID: <20200714021544.GA1141578@bogus>
References: <20200623025106.31273-1-afaerber@suse.de>
 <20200623025106.31273-25-afaerber@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200623025106.31273-25-afaerber@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 23 Jun 2020 04:51:01 +0200, Andreas Färber wrote:
> Allow to optionally specify nvmem cells to identify the chip.
> RTD1295 family will want the eFuse package_id cell.
> 
> Signed-off-by: Andreas Färber <afaerber@suse.de>
> ---
>  v1 -> v2:
>  * Instead of extending reg, allow nvmem-cells reference for eFuse
> 
>  .../bindings/soc/realtek/realtek,rtd1195-chip.yaml   | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
