Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52085249710
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Aug 2020 09:22:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727118AbgHSHWp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Aug 2020 03:22:45 -0400
Received: from muru.com ([72.249.23.125]:41000 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726612AbgHSHWn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Aug 2020 03:22:43 -0400
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id E80458107;
        Wed, 19 Aug 2020 07:22:43 +0000 (UTC)
Date:   Wed, 19 Aug 2020 10:23:12 +0300
From:   Tony Lindgren <tony@atomide.com>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-kernel@vger.kernel.org, Aaro Koskinen <aaro.koskinen@iki.fi>,
        linux-omap@vger.kernel.org
Subject: Re: [PATCH] arm: mach-omap1: mux.h: delete duplicate word
Message-ID: <20200819072312.GC2994@atomide.com>
References: <20200726002212.19896-1-rdunlap@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200726002212.19896-1-rdunlap@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Randy Dunlap <rdunlap@infradead.org> [200726 03:22]:
> Drop the repeated word "is".

Thanks applying into omap-for-v5.9/omap1.

Tony
