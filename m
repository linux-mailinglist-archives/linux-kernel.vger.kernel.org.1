Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC01D291004
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Oct 2020 08:09:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436922AbgJQGJF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Oct 2020 02:09:05 -0400
Received: from asavdk4.altibox.net ([109.247.116.15]:57748 "EHLO
        asavdk4.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2436910AbgJQGJE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Oct 2020 02:09:04 -0400
Received: from ravnborg.org (unknown [188.228.123.71])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by asavdk4.altibox.net (Postfix) with ESMTPS id 0F7AB8055C;
        Sat, 17 Oct 2020 08:09:00 +0200 (CEST)
Date:   Sat, 17 Oct 2020 08:08:58 +0200
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     thierry.reding@gmail.com, linux-amlogic@lists.infradead.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v4 0/4] drm: panel: add support for TDO tl070wsh30 panel
Message-ID: <20201017060858.GA2242298@ravnborg.org>
References: <20200915121912.4347-1-narmstrong@baylibre.com>
 <9f720791-2718-205f-d101-0811a679f54e@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9f720791-2718-205f-d101-0811a679f54e@baylibre.com>
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=fu7ymmwf c=1 sm=1 tr=0
        a=S6zTFyMACwkrwXSdXUNehg==:117 a=S6zTFyMACwkrwXSdXUNehg==:17
        a=kj9zAlcOel0A:10 a=7gkXJVJtAAAA:8 a=Gz7jjY5onqyk-6-21tUA:9
        a=CjuIK1q_8ugA:10 a=H9xpq_V2WxwA:10 a=QYH75iMubAgA:10
        a=E9Po1WZjFZOl8hwRPBS3:22
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Neil.

On Tue, Sep 29, 2020 at 11:25:17AM +0200, Neil Armstrong wrote:
> Hi Sam,
> 
> Is there anything more to change ?
Sorry for taking so long to get back to you on this.

All patches looks good and are:
Reviewed-by: Sam Ravnborg <sam@ravnborg.org>

I assume you will apply the patches.

	Sam
