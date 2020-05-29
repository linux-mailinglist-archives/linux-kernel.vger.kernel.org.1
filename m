Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4189E1E7ED7
	for <lists+linux-kernel@lfdr.de>; Fri, 29 May 2020 15:34:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727047AbgE2Nem (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 May 2020 09:34:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726905AbgE2Nei (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 May 2020 09:34:38 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34468C03E969;
        Fri, 29 May 2020 06:34:38 -0700 (PDT)
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1jef9d-0005JK-K9; Fri, 29 May 2020 15:34:33 +0200
Date:   Fri, 29 May 2020 15:34:33 +0200
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        kamel.bouhara@bootlin.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/9] dt-bindings: atmel-tcb: convert bindings to
 json-schema
Message-ID: <20200529133433.mr3fp4rfd5l4scxw@linutronix.de>
References: <20200506080554.283177-1-alexandre.belloni@bootlin.com>
 <20200506080554.283177-2-alexandre.belloni@bootlin.com>
 <20200529101314.2ueuhgnrqq3a764f@linutronix.de>
 <20200529132118.GF3972@piout.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200529132118.GF3972@piout.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-05-29 15:21:18 [+0200], Alexandre Belloni wrote:
> There is actually one comment I need to address that Rob made on another
> series that was also including this patch. I'll send a new version
> today.

Ah, okay. Thanks for the info, that thread looked dead.

Sebastian
