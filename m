Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0AB3249704
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Aug 2020 09:20:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727854AbgHSHU5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Aug 2020 03:20:57 -0400
Received: from muru.com ([72.249.23.125]:40980 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726783AbgHSHUt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Aug 2020 03:20:49 -0400
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 71A7B8107;
        Wed, 19 Aug 2020 07:20:49 +0000 (UTC)
Date:   Wed, 19 Aug 2020 10:21:17 +0300
From:   Tony Lindgren <tony@atomide.com>
To:     "Alexander A. Klimov" <grandmaster@al2klimov.de>
Cc:     khilman@kernel.org, linux@armlinux.org.uk,
        linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH for v5.9] ARM: OMAP2+: pm33xx-core: Replace HTTP links
 with HTTPS ones
Message-ID: <20200819072117.GA2994@atomide.com>
References: <20200719091912.57273-1-grandmaster@al2klimov.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200719091912.57273-1-grandmaster@al2klimov.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Alexander A. Klimov <grandmaster@al2klimov.de> [200719 12:27]:
> Rationale:
> Reduces attack surface on kernel devs opening the links for MITM
> as HTTPS traffic is much harder to manipulate.

Thanks applying into omap-for-v5.10/soc.

Tony
