Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10B3F2C1700
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Nov 2020 21:50:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730170AbgKWUsA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Nov 2020 15:48:00 -0500
Received: from asavdk4.altibox.net ([109.247.116.15]:37536 "EHLO
        asavdk4.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727461AbgKWUr7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Nov 2020 15:47:59 -0500
Received: from ravnborg.org (unknown [188.228.123.71])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by asavdk4.altibox.net (Postfix) with ESMTPS id 9C8B980680;
        Mon, 23 Nov 2020 21:47:56 +0100 (CET)
Date:   Mon, 23 Nov 2020 21:47:55 +0100
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Subject: Re: [PATCH 1/2] dt-bindings: panel-simple-dsi: add Khadas TS050
 panel bindings
Message-ID: <20201123204755.GA671311@ravnborg.org>
References: <20201123143354.295844-1-narmstrong@baylibre.com>
 <20201123143354.295844-2-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201123143354.295844-2-narmstrong@baylibre.com>
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=VafZwmh9 c=1 sm=1 tr=0
        a=S6zTFyMACwkrwXSdXUNehg==:117 a=S6zTFyMACwkrwXSdXUNehg==:17
        a=kj9zAlcOel0A:10 a=IpJZQVW2AAAA:8 a=7gkXJVJtAAAA:8
        a=GTP7ad_MgPmXoif0-bwA:9 a=CjuIK1q_8ugA:10 a=IawgGOuG5U0WyFbmm1f5:22
        a=E9Po1WZjFZOl8hwRPBS3:22
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 23, 2020 at 03:33:53PM +0100, Neil Armstrong wrote:
> This add the bindings for the Khadas TS050 1080x1920 5" LCD DSI panel designed to work
> with the Khadas Edge-V, Captain, VIM3 and VIM3L Single Board Computers.
> 
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
Reviewed-by: Sam Ravnborg <sam@ravnborg.org>
