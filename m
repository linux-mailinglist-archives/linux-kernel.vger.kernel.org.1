Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE6382C5D6F
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Nov 2020 22:15:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732043AbgKZVPE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Nov 2020 16:15:04 -0500
Received: from static.214.254.202.116.clients.your-server.de ([116.202.254.214]:60892
        "EHLO ciao.gmane.io" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726178AbgKZVPE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Nov 2020 16:15:04 -0500
Received: from list by ciao.gmane.io with local (Exim 4.92)
        (envelope-from <glk-linux-kernel-4@m.gmane-mx.org>)
        id 1kiObW-0003Ni-HP
        for linux-kernel@vger.kernel.org; Thu, 26 Nov 2020 22:15:02 +0100
X-Injected-Via-Gmane: http://gmane.org/
To:     linux-kernel@vger.kernel.org
From:   deloptes <deloptes@gmail.com>
Subject: Re: [PATCH 134/141] video: fbdev: lxfb_ops: Fix fall-through warnings for Clang
Followup-To: gmane.linux.kernel
Date:   Tue, 24 Nov 2020 21:58:16 +0100
Lines:  11
Message-ID: <rpjs58$i5n$1@ciao.gmane.io>
References: <cover.1605896059.git.gustavoars@kernel.org> <9c1dcb12aae7c7ff0907ffb99ffd227656cbe444.1605896060.git.gustavoars@kernel.org> <20201122220540.GC566387@ravnborg.org> <20201124144407.GI16084@embeddedor>
Reply-To: deloptes@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
User-Agent: KNode/0.10.9
X-Face: &bB+dG6r\D$gd^NFeYm<f{n8m&2W,Lr'h>#MNOHtI/(z<->Su~)mL1rYXAE7W:U2d;tQAEP  ?3('tC@:iV_x)~3Kq.-X\\j1HU;i6/u\An"y=\gO%d`v#QdRgaw9JySH|xOp&6giT2q+z3j<t`[9@b  _&-<C%rE*@-)n9uI5?P_u9`8x.@SeM*h,'bBR~v^^XiU[Y&\/L6(jEpen8eNtlhu!p)GYOW6Iny
Cc:     dri-devel@lists.freedesktop.org, linux-geode@bombadil.infradead.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Gustavo A. R. Silva wrote:

> Absolutely. We'll never know how many bugs this will catch in the
> future decades of kernel development, before the code is even
> committed/submitted. :)

A little bit OT here, but what are the plans for Geode in general as there
was discussion around the fact that Debian will be one of the last
platforms to drop i386 arch support.

Thank you

