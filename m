Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76D8A302EF9
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jan 2021 23:26:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732066AbhAYWY5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jan 2021 17:24:57 -0500
Received: from mail-oi1-f175.google.com ([209.85.167.175]:37670 "EHLO
        mail-oi1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732252AbhAYWYj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jan 2021 17:24:39 -0500
Received: by mail-oi1-f175.google.com with SMTP id r189so16502989oih.4;
        Mon, 25 Jan 2021 14:24:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=0NjYeDD1lzj1UZeJ9nl8y/ztWhDb5GAabmpEUTqpWuo=;
        b=EPYRiaMo/U0wTmAtZgPZ6/IdxUwf6GhlWKE7iQfzHiP0qD9M2dLXd/+AOcMJOVr8qn
         HTiZwX959eQL71CiH07RNzcHnDTBjEf46Scw/jhcqYDUxoi9nZPg2skURGlY1+AZeOVC
         WnjAWJ649JX3EsLNBMM0se8DJZ2QSjA0kprueXennEkR+/Ji5UAPOiakjSVnsnJ/A1xp
         anW3/rfSwpmxrDZCfgD6NnDO2ePlx2LUoPVlezd7AqyTVgbwe3Fjnf1SxR5P2+Ec9xgO
         BF06HY/hsBzFka8muq/I4DML9lnowZyAjucRF8865vWXAVPb/lwdaluC98kt0ikRTIN5
         3ilQ==
X-Gm-Message-State: AOAM531KLZ1QkXzCURtgeG63PhbVF/wUR9iBV6iaGvgQ4NNoBGnIgDTh
        hVVl5elAqtSSX0cclHGEoQ==
X-Google-Smtp-Source: ABdhPJyiC85YjLm3GdEPgUAZ01e4BVRyZ2WIvAASAZ4Nfi00rOeQsMsqQRoTcgV1oRHZeeEIutbAsw==
X-Received: by 2002:a05:6808:c:: with SMTP id u12mr1364028oic.163.1611613436039;
        Mon, 25 Jan 2021 14:23:56 -0800 (PST)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id d10sm3459431ooh.32.2021.01.25.14.23.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Jan 2021 14:23:55 -0800 (PST)
Received: (nullmailer pid 1131708 invoked by uid 1000);
        Mon, 25 Jan 2021 22:23:54 -0000
Date:   Mon, 25 Jan 2021 16:23:54 -0600
From:   Rob Herring <robh@kernel.org>
To:     =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
Cc:     linux-mtd@lists.infradead.org,
        Boris Brezillon <bbrezillon@kernel.org>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-kernel@vger.kernel.org,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Rob Herring <robh+dt@kernel.org>,
        =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>,
        devicetree@vger.kernel.org
Subject: Re: [PATCH 1/3] dt-bindings: mtd: move partition binding to its own
 file
Message-ID: <20210125222354.GA1131674@robh.at.kernel.org>
References: <20210115153901.31052-1-zajec5@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210115153901.31052-1-zajec5@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 15 Jan 2021 16:38:59 +0100, Rafał Miłecki wrote:
> From: Rafał Miłecki <rafal@milecki.pl>
> 
> Single partition binding is quite common and may be:
> 1. Used by multiple parsers
> 2. Extended for more specific cases
> 
> Move it to separated file to avoid code duplication.
> 
> Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
> ---
>  .../mtd/partitions/fixed-partitions.yaml      | 33 +------------
>  .../bindings/mtd/partitions/partition.yaml    | 47 +++++++++++++++++++
>  2 files changed, 48 insertions(+), 32 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/mtd/partitions/partition.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
