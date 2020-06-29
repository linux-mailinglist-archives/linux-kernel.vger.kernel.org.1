Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6018A20D28C
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jun 2020 20:51:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729510AbgF2SuS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Jun 2020 14:50:18 -0400
Received: from muru.com ([72.249.23.125]:59950 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729465AbgF2SuL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 14:50:11 -0400
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 4A4F581BF;
        Mon, 29 Jun 2020 18:15:31 +0000 (UTC)
Date:   Mon, 29 Jun 2020 11:14:35 -0700
From:   Tony Lindgren <tony@atomide.com>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        =?utf-8?Q?Beno=C3=AEt?= Cousson <bcousson@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>, linux-omap@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH] ARM: dts: am: Align L2 cache-controller nodename with
 dtschema
Message-ID: <20200629181435.GA37466@atomide.com>
References: <20200626080651.4355-1-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200626080651.4355-1-krzk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Krzysztof Kozlowski <krzk@kernel.org> [200626 01:07]:
> Fix dtschema validator warnings like:
>     l2-cache-controller@48242000: $nodename:0: 'l2-cache-controller@48242000'
>         does not match '^(cache-controller|cpu)(@[0-9a-f,]+)*$'

Applying into omap-for-v5.9/dt thanks.

Tony
