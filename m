Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18C8D203E1D
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jun 2020 19:36:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730087AbgFVRfy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Jun 2020 13:35:54 -0400
Received: from asavdk4.altibox.net ([109.247.116.15]:41216 "EHLO
        asavdk4.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729918AbgFVRfy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 13:35:54 -0400
Received: from ravnborg.org (unknown [188.228.123.71])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by asavdk4.altibox.net (Postfix) with ESMTPS id 4A6B4804D8;
        Mon, 22 Jun 2020 19:35:50 +0200 (CEST)
Date:   Mon, 22 Jun 2020 19:35:48 +0200
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Vladimir Oltean <olteanv@gmail.com>
Cc:     kernel test robot <lkp@intel.com>, thierry.reding@gmail.com,
        airlied@linux.ie, daniel@ffwll.ch, dri-devel@lists.freedesktop.org,
        kbuild-all@lists.01.org, clang-built-linux@googlegroups.com,
        lkml <linux-kernel@vger.kernel.org>,
        Mark Brown <broonie@kernel.org>
Subject: Re: drivers/gpu/drm/panel/panel-samsung-ld9040.c:240:12: warning:
 stack frame size of 8312 bytes in function 'ld9040_prepare'
Message-ID: <20200622173548.GA770766@ravnborg.org>
References: <202006210249.QHly8bQZ%lkp@intel.com>
 <CA+h21hpABfDvthiwq_JwWGpqZ68VJxu5TOBVbw_Gaxpq8j+XQg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+h21hpABfDvthiwq_JwWGpqZ68VJxu5TOBVbw_Gaxpq8j+XQg@mail.gmail.com>
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=G88y7es5 c=1 sm=1 tr=0
        a=S6zTFyMACwkrwXSdXUNehg==:117 a=S6zTFyMACwkrwXSdXUNehg==:17
        a=kj9zAlcOel0A:10 a=jUwGT8AIfRSel3yE9RIA:9 a=CjuIK1q_8ugA:10
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vladimir

> I really don't get what's the problem here. The listing of
> ld9040_prepare at the given commit and with the given .config is:

The culprint is likely ld9040_brightness_set() that is inlined.

I think we have troubles with

    static u8 const ld9040_gammas[25][22]

I did not look closely but if you can reproduce this is where I think you
should look.

	Sam
