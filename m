Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0CCC1210A33
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jul 2020 13:20:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730194AbgGALUG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jul 2020 07:20:06 -0400
Received: from asavdk4.altibox.net ([109.247.116.15]:36326 "EHLO
        asavdk4.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730133AbgGALUG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 07:20:06 -0400
Received: from ravnborg.org (unknown [188.228.123.71])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by asavdk4.altibox.net (Postfix) with ESMTPS id EC378804B9;
        Wed,  1 Jul 2020 13:20:02 +0200 (CEST)
Date:   Wed, 1 Jul 2020 13:20:01 +0200
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Vinay Simha B N <simhavcs@gmail.com>
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        Ken-Sue.Tan@taec.toshiba.com, Chris.Cheng@taec.toshiba.com,
        Bhushan.Patel@taec.toshiba.com,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, David Airlie <airlied@linux.ie>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:DRM DRIVERS" <dri-devel@lists.freedesktop.org>,
        Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH v5 1/2] dt-binding: Add DSI/LVDS TC358775 bridge bindings
Message-ID: <20200701112001.GA652928@ravnborg.org>
References: <20200701070344.6330-1-simhavcs@gmail.com>
 <20200701091940.GB266726@ravnborg.org>
 <CAGWqDJ51_QRHLP0mUyaCJCiKMJkGmbwuR9y2rZ=t=Mo7gCdb1w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGWqDJ51_QRHLP0mUyaCJCiKMJkGmbwuR9y2rZ=t=Mo7gCdb1w@mail.gmail.com>
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=aP3eV41m c=1 sm=1 tr=0
        a=S6zTFyMACwkrwXSdXUNehg==:117 a=S6zTFyMACwkrwXSdXUNehg==:17
        a=kj9zAlcOel0A:10 a=Nvn8WTl6hB1VAHlkLJEA:9 a=CjuIK1q_8ugA:10
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vinay.

On Wed, Jul 01, 2020 at 03:14:09PM +0530, Vinay Simha B N wrote:
> sam,
> 
> I rechecked, but did not find any indents are too spaced.
> This is taken from a working dts tree.
> 
            port@1 {
            |   reg = <1>;
            |   dsi0_out: endpoint {
            |       remote-endpoint = <&d2l_in_test>;
            |           data-lanes = <0 1 2 3>;
            |   };
             };
         };
     };
See above, something is wrong with the indent in the examples.


> I had given two examples for a purpose. One for single lvds
> configuration single link mode,
> another is for dual lvds configurations dual-link mode and port mappings.

Please provide a proper description of the single link and dual link
modes in the descriptions of the bindings.
The examples shall support the bindings, they shall not include
information that is not covered in the bindings.

	Sam
