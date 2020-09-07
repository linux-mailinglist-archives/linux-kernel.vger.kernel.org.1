Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3A9125F8EC
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Sep 2020 12:55:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728802AbgIGKy4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Sep 2020 06:54:56 -0400
Received: from asavdk3.altibox.net ([109.247.116.14]:37858 "EHLO
        asavdk3.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728575AbgIGKyo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Sep 2020 06:54:44 -0400
Received: from ravnborg.org (unknown [188.228.123.71])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by asavdk3.altibox.net (Postfix) with ESMTPS id 8F1C620024;
        Mon,  7 Sep 2020 12:54:30 +0200 (CEST)
Date:   Mon, 7 Sep 2020 12:54:28 +0200
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     thierry.reding@gmail.com, dri-devel@lists.freedesktop.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] drm: panel: add support for TDO tl070wsh30 panel
Message-ID: <20200907105428.GA523433@ravnborg.org>
References: <20200904161504.23915-1-narmstrong@baylibre.com>
 <7e63abb2-89d1-3047-29c2-d312ba5ce16d@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7e63abb2-89d1-3047-29c2-d312ba5ce16d@baylibre.com>
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=CaYmGojl c=1 sm=1 tr=0
        a=S6zTFyMACwkrwXSdXUNehg==:117 a=S6zTFyMACwkrwXSdXUNehg==:17
        a=kj9zAlcOel0A:10 a=YRok_seE1VY6wa09Rq8A:9 a=CjuIK1q_8ugA:10
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 07, 2020 at 12:33:41PM +0200, Neil Armstrong wrote:
> Hi,
> 
> Please ignore this serie, the vendors patch is missing and the panel driver
> still has the vrefresh...
> 
> Will repost.

Please fix so DRM_DEV_* is replaced by dev_* logging.
We no longer use the DRM_ based logging for panels.

Drop drm_print.h from includes and fix build.

I did not read the code just noticed this detail.

	Sam
