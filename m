Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 430761B2CBF
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Apr 2020 18:33:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728972AbgDUQdA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Apr 2020 12:33:00 -0400
Received: from muru.com ([72.249.23.125]:50614 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725987AbgDUQc7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Apr 2020 12:32:59 -0400
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 6DF388081;
        Tue, 21 Apr 2020 16:33:46 +0000 (UTC)
Date:   Tue, 21 Apr 2020 09:32:55 -0700
From:   Tony Lindgren <tony@atomide.com>
To:     Faiz Abbas <faiz_abbas@ti.com>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-omap@vger.kernel.org, mark.rutland@arm.com,
        robh+dt@kernel.org, bcousson@baylibre.com
Subject: Re: [PATCH] ARM: dts: am574x-idk: Disable m_can node
Message-ID: <20200421163255.GV37466@atomide.com>
References: <20200401090858.18523-1-faiz_abbas@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200401090858.18523-1-faiz_abbas@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Faiz Abbas <faiz_abbas@ti.com> [200401 02:09]:
> Since commit bcbb63b80284 ("ARM: dts: dra7: Separate AM57 dtsi files"),
> the m_can node was inherited from dra76x.dtsi but the IP is not
> connected on the idk board. Disable the node to reflect this.

Applying into fixes thanks.

Tony
