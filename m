Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6FABB27410E
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Sep 2020 13:38:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726573AbgIVLiw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Sep 2020 07:38:52 -0400
Received: from honk.sigxcpu.org ([24.134.29.49]:34034 "EHLO honk.sigxcpu.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726518AbgIVLiu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Sep 2020 07:38:50 -0400
Received: from localhost (localhost [127.0.0.1])
        by honk.sigxcpu.org (Postfix) with ESMTP id 5B8A2FB03;
        Tue, 22 Sep 2020 13:38:48 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at honk.sigxcpu.org
Received: from honk.sigxcpu.org ([127.0.0.1])
        by localhost (honk.sigxcpu.org [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 0v3BqV8ZcSuj; Tue, 22 Sep 2020 13:38:47 +0200 (CEST)
Received: by bogon.sigxcpu.org (Postfix, from userid 1000)
        id 1BA5B457CC; Tue, 22 Sep 2020 13:38:47 +0200 (CEST)
Date:   Tue, 22 Sep 2020 13:38:47 +0200
From:   Guido =?iso-8859-1?Q?G=FCnther?= <agx@sigxcpu.org>
To:     Fabio Estevam <festevam@gmail.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        DRI mailing list <dri-devel@lists.freedesktop.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH v1 3/3] dt-binding: display: Require two rests on
 mantix panel
Message-ID: <20200922113847.GA17611@bogon.m.sigxcpu.org>
References: <cover.1600707235.git.agx@sigxcpu.org>
 <71a9108f3472ba9af4bead01b1b770d1e73eb08e.1600707235.git.agx@sigxcpu.org>
 <CAOMZO5B5ECcConvKej=RcaF8wvOxgq7nUzKJ-ad0aSAOzUqtbQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOMZO5B5ECcConvKej=RcaF8wvOxgq7nUzKJ-ad0aSAOzUqtbQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
On Mon, Sep 21, 2020 at 02:05:55PM -0300, Fabio Estevam wrote:
> Hi Guido,
> 
> On Mon, Sep 21, 2020 at 1:56 PM Guido Günther <agx@sigxcpu.org> wrote:
> >
> > We need to reset both for the panel to show an image.
> 
> There is a typo in "resets" in the Subject line.

Fix queued for v2. Thanks!
 -- Guido
