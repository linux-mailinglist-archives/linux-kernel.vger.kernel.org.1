Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48C6C268F87
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Sep 2020 17:20:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726357AbgINPUO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Sep 2020 11:20:14 -0400
Received: from kylie.crudebyte.com ([5.189.157.229]:52141 "EHLO
        kylie.crudebyte.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725997AbgINPTi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Sep 2020 11:19:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=crudebyte.com; s=kylie; h=Content-Type:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
        Content-ID:Content-Description;
        bh=IiQzWNzedauPyLVA9z0iBW2QLEA08tfWMzr6ARLoZVE=; b=A0G3RgALAwLHAmd65ENtiXIOSX
        v1OiuZ6rUFL2gTm+ku2xG07l+3U/1YCn1FrIYsJ3J8hDAgHTmeFzmcH2ydR7iojrt9/x3gh0jacjm
        8NWiQ77JDB/Wszwd8MaauHBL8AuvsZROohRBVhrjy37WOiDwu6fqxIkfhK3aL6rGqIMt7ypTUFoiK
        7GQ9MxQYIeuc/43bUchyXLBnAksuso2WpeU0viQkDXbUI4ML1/4LhZfK9LZqtLX1P90tynmM2nIlz
        gjGGRb0mnJnk+DmpMXOE/agQCkQd7GpbiUP5fCwYL+g61o/s1HC/014bgqx8mAguACXzkyiAmjvWz
        UeDN0Lgb2v7iQ+7fCeA6pZV5up65iUXM/EUCq/uktZgL3X13a1GqBEDEQ4vz6iBkS3cazN5NtswnR
        +DhhNa5d253RppT1/sU7dAJ0eo5QqcpV6spCbz9hrGnDo2lClefn6i41oE6/YFkBgeeZliy0rMwyK
        zgmC6o1V2SU7QgT/wL2Tr/0wcZjJRu7HahWOedcbiDlu4xfcNLFmkvqwFYbSAYpQHitS99scsO25t
        7Ejgcn5c378kpx42qkxwPjgQbbF6rUuMrVm+/FSgkDHs92hEgjPH04hpbynK/cR1EP5t+vPW9bzZR
        P7RpXvrP1TYZ6UlEoAD4tFdRYCogoSfsKSi/KnR6c=;
From:   Christian Schoenebeck <qemu_oss@crudebyte.com>
To:     Greg Kurz <groug@kaod.org>
Cc:     Jianyong Wu <jianyong.wu@arm.com>, ericvh@gmail.com,
        lucho@ionkov.net, asmadeus@codewreck.org,
        v9fs-developer@lists.sourceforge.net, justin.he@arm.com,
        linux-kernel@vger.kernel.org
Subject: Re: [V9fs-developer] [PATCH RFC 0/4] 9p: fix open-unlink-f*syscall bug
Date:   Mon, 14 Sep 2020 17:19:20 +0200
Message-ID: <2037087.W39pGsgtbe@silver>
In-Reply-To: <20200914144325.7928dbd3@bahia.lan>
References: <20200914033754.29188-1-jianyong.wu@arm.com> <2828347.d8MXItvaOC@silver> <20200914144325.7928dbd3@bahia.lan>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Montag, 14. September 2020 14:43:25 CEST Greg Kurz wrote:
> > So yes, looks like this also requires changes to the 9pfs 'local' fs
> > driver on QEMU side:
> > https://lists.nongnu.org/archive/html/qemu-devel/2016-06/msg07586.html
> > 
> > Eric, Greg, would there be an easy way to establish QEMU test cases
> > running
> > the 9pfs 'local' fs driver? Right now we only have 9pfs qtest cases for
> > QEMU which can only use the 'synth' driver, which is not helpful for such
> > kind of issues.
> 
> I guess it's possible to introduce new qtests that start QEMU with
> -fsdev local instead of -fsdev synth... I haven't looked in a while
> though, so I won't comment on "easy way" ;-)

Makes sense, and I considered that approach as well.

The question is the following: is there a QEMU policy about test cases that 
create/write/read/delete *real* files? I.e. should those test files be written 
to a certain location, and are there measures of sandboxing required?

Best regards,
Christian Schoenebeck


