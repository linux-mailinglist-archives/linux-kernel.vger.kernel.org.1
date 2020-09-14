Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6B4526994E
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Sep 2020 00:58:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726062AbgINW6M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Sep 2020 18:58:12 -0400
Received: from mail-il1-f195.google.com ([209.85.166.195]:43006 "EHLO
        mail-il1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725926AbgINW6J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Sep 2020 18:58:09 -0400
Received: by mail-il1-f195.google.com with SMTP id t13so1178955ile.9;
        Mon, 14 Sep 2020 15:58:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=kq6qlG5VJYZXUU2sGGyka4Jem/75zC6Wn5AvRmVlrlc=;
        b=NDB42gVLREaFd+W0A/uAsmv7H34J60SrKrcxinvqRJHcMWsbQ93rhWrgXcdSrs/Opl
         i9FMzTVDrI2B4wkoqNA7mvrKpHBQZwQrVZRdNTTKP9EKeB8TPrmaPAbrPjKyDTksa9Wf
         c55OQIcvhypjd0ZEDpB1rqWPtcVTu4pB28yvRSCFmWT7ieHBNpkq0lzCDVrd4Jibkrhb
         VEe+mC+VFDs5HBV3mTW8pfaF8Q+zk8O0Wx0J5NDL7/c0gLD77v57jVP0yX3gGyZEvbUz
         AHwytPt1Pnv+KBzpV8QJsJQ6hpRleeyImjx+AsImyYRHYvw8pvfZn63pUPm7KEcmffR0
         +W7A==
X-Gm-Message-State: AOAM530D8TK4OE4BjGuVXBNBGcJ81DElndkOyiCv3sEjruX59MZqFWkn
        YTIFte6GeuEarrZBvuVZkPzj8UoB70gP
X-Google-Smtp-Source: ABdhPJzjV3LJ6Z9bth40387EREf7eFPmbglblttVdwLb5FiWraVR0VU+a+NG+uwN+G/NZGfVF0l6zQ==
X-Received: by 2002:a05:6e02:be6:: with SMTP id d6mr13897302ilu.76.1600124288223;
        Mon, 14 Sep 2020 15:58:08 -0700 (PDT)
Received: from xps15 ([64.188.179.253])
        by smtp.gmail.com with ESMTPSA id u14sm7196498ilj.7.2020.09.14.15.58.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2020 15:58:07 -0700 (PDT)
Received: (nullmailer pid 427460 invoked by uid 1000);
        Mon, 14 Sep 2020 22:58:06 -0000
Date:   Mon, 14 Sep 2020 16:58:06 -0600
From:   Rob Herring <robh@kernel.org>
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, khilman@baylibre.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH RESEND 1/2] dt-bindings: power: amlogic, meson-ee-pwrc:
 add Amlogic AXG power controller bindings
Message-ID: <20200914225806.GA427430@bogus>
References: <20200904161654.24141-1-narmstrong@baylibre.com>
 <20200904161654.24141-2-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200904161654.24141-2-narmstrong@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 04 Sep 2020 18:16:53 +0200, Neil Armstrong wrote:
> This adds the bindings of the Power Controller found in the Amlogic AXG SoCs.
> 
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> ---
>  .../bindings/power/amlogic,meson-ee-pwrc.yaml | 23 +++++++++++++++++--
>  include/dt-bindings/power/meson-axg-power.h   | 14 +++++++++++
>  2 files changed, 35 insertions(+), 2 deletions(-)
>  create mode 100644 include/dt-bindings/power/meson-axg-power.h
> 

Reviewed-by: Rob Herring <robh@kernel.org>
