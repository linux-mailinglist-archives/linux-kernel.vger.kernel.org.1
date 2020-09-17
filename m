Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C835426D8F0
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Sep 2020 12:25:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726588AbgIQKZJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Sep 2020 06:25:09 -0400
Received: from kylie.crudebyte.com ([5.189.157.229]:60447 "EHLO
        kylie.crudebyte.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726701AbgIQKYk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Sep 2020 06:24:40 -0400
X-Greylist: delayed 995 seconds by postgrey-1.27 at vger.kernel.org; Thu, 17 Sep 2020 06:24:39 EDT
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=crudebyte.com; s=kylie; h=Content-Type:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
        Content-ID:Content-Description;
        bh=XLwyjyrxqdv/odAe618s6NJTVoSCd7gxAmFBuvC2SXQ=; b=pn+1IAk4kYKoI7SK8u7p6HYcg/
        Ar9FJRiJ0HVgmUE26zkpE0Z2QWH76ROWtN9EIUW/MiluYs6iOx2xBTVhLy4MakUxDv1WqesGUV3xN
        FSh7rNZBMKqsCPQVEWaIbC+nv5B5lkdVJTc294spr8HqlcK4WrNFR2Yw2FEslQ9+9r7LpMFZaxrBu
        noV9k9gFI4WhCfT1Pzf9S6ISn7hxm4ZSVUhqw0uB+ifCW7wwBmdKsLwZdozTGOD0zrQHNFy0uRWcc
        bhLQE79C6jol13wh3s8wHWXEY6mLhNnP9lXmcO15pGczpGp7xP6AiGKlcjzPvcaYJKEihpK83bGAB
        l6PVUVo/XgQ4BmzgDTTfQZ8UicTmUnrP8hMyWhI2qJtt2p9yv66hC7RadSyKb+JNKSQdYZFZN4O1j
        G/ys5hiW68Mp6wtqa3dWpGqnpVu559tfULZlVJ98PLPwSlD2jlsHE+5wDgPJGFFpZ7A5d7ktYlHPn
        BuBHldPSWWMWnEa0NI8QvHI7ZHvNI6VB/GEa5jJvC2uqSE37IE94YFjUM2VFTAgW+ZrgYGvds91Uz
        hAnvHTo5mXgZ2u2pTuxdD4Tkb/NhUwWODE5svl2XMuCmCwVJj5h+arhi6A6Fw7gbSTF+GKEt8WS8l
        Ms/U2HH12lPMXFD8Y7MLEJkXNSK+D+ZfVL7JnjjlA=;
From:   Christian Schoenebeck <qemu_oss@crudebyte.com>
To:     Greg Kurz <groug@kaod.org>
Cc:     Jianyong Wu <jianyong.wu@arm.com>, ericvh@gmail.com,
        lucho@ionkov.net, asmadeus@codewreck.org,
        v9fs-developer@lists.sourceforge.net, justin.he@arm.com,
        linux-kernel@vger.kernel.org
Subject: Re: [V9fs-developer] [PATCH RFC 0/4] 9p: fix open-unlink-f*syscall bug
Date:   Thu, 17 Sep 2020 12:07:52 +0200
Message-ID: <1994640.yx8tjih9BC@silver>
In-Reply-To: <20200916141621.5de7d397@bahia.lan>
References: <20200914033754.29188-1-jianyong.wu@arm.com> <20200914174630.195e816f@bahia.lan> <20200916141621.5de7d397@bahia.lan>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mittwoch, 16. September 2020 14:16:21 CEST Greg Kurz wrote:
> On Mon, 14 Sep 2020 17:46:30 +0200
> 
> Greg Kurz <groug@kaod.org> wrote:
> > On Mon, 14 Sep 2020 17:19:20 +0200
> > 
> > Christian Schoenebeck <qemu_oss@crudebyte.com> wrote:
> > > On Montag, 14. September 2020 14:43:25 CEST Greg Kurz wrote:
> > > > > So yes, looks like this also requires changes to the 9pfs 'local' fs
> > > > > driver on QEMU side:
> > > > > https://lists.nongnu.org/archive/html/qemu-devel/2016-06/msg07586.ht
> > > > > ml
> > > > > 
> > > > > Eric, Greg, would there be an easy way to establish QEMU test cases
> > > > > running
> > > > > the 9pfs 'local' fs driver? Right now we only have 9pfs qtest cases
> > > > > for
> > > > > QEMU which can only use the 'synth' driver, which is not helpful for
> > > > > such
> > > > > kind of issues.
> > > > 
> > > > I guess it's possible to introduce new qtests that start QEMU with
> > > > -fsdev local instead of -fsdev synth... I haven't looked in a while
> > > > though, so I won't comment on "easy way" ;-)
> > > 
> > > Makes sense, and I considered that approach as well.
> > > 
> > > The question is the following: is there a QEMU policy about test cases
> > > that
> > > create/write/read/delete *real* files? I.e. should those test files be
> > > written to a certain location, and are there measures of sandboxing
> > > required?> 
> > I don't know. You'll need to figure out by yourself, reading code from
> > other tests or asking on IRC.
> 
> Maybe Thomas (added in Cc) can give some hints on how test cases should
> handle creation/deletion of real files ?

Got this QEMU policy issue clarified on qemu-devel in the meantime.

Back on topic: I can lay the ground on QEMU side by establishing a test suite 
for the 9p 'local' driver, including one test case ready to pass for this 
particular unlinked-I/O bug discussed here.

But to be clear: since the proposed patch set is a non-trivial and old one 
(2016), I currently don't have plans to handle the actual bug fix patches by 
myself. So if anyone wants this unlinked issue to be fixed on QEMU side, 
please dedust that patch set and send a v2 the common way to qemu-devel ML for 
further review, and actually test them!

So if anybody wants to do that, let me know, so that I would prepare the test 
suite in the meantime.

Best regards,
Christian Schoenebeck


