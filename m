Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7353526A06D
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Sep 2020 10:10:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726179AbgIOIK0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Sep 2020 04:10:26 -0400
Received: from mout.gmx.net ([212.227.15.15]:37973 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726243AbgIOIIs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Sep 2020 04:08:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1600157274;
        bh=XMcvQTmJcpC2V5nhPWBPfdGZFJFYkc6FXJ0jHmXnP5c=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=P0WJKyyqh8wxSdR9wkKDsHOCFIC8dJUEo6VSq572NpAs8JWnQpI7TPcL5tDu0DAFx
         YX61sxNmMpVXlZKPM09oiCWdR72GFsoWDUS9cGvvi4YJTw/aYH5NhOM9vZacrtF+VT
         3yZ7+IesXw/chI7MdiZWAMt/YS0jhoVMLNFuoY0g=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [80.208.209.101] ([80.208.209.101]) by web-mail.gmx.net
 (3c-app-gmx-bs08.server.lan [172.19.170.59]) (via HTTP); Tue, 15 Sep 2020
 10:07:54 +0200
MIME-Version: 1.0
Message-ID: <trinity-c0da4c5b-abb3-43d3-ac62-2578966c6613-1600157274519@3c-app-gmx-bs08>
From:   Frank Wunderlich <frank-w@public-files.de>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Michal Marek <michal.lkml@markovi.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Aw: Re: [question] KBUILD_OUTPUT and modules install (with
 INSTALL_MOD_PATH)
Content-Type: text/plain; charset=UTF-8
Date:   Tue, 15 Sep 2020 10:07:54 +0200
Importance: normal
Sensitivity: Normal
In-Reply-To: <CAK7LNATk0=gLquyX3W90xcX60O++fhrhjTHJv0k-=vuhGVg5AQ@mail.gmail.com>
References: <trinity-9cd01270-7c54-4bf5-810d-e1b7de352e11-1600106229398@3c-app-gmx-bs03>
 <CAK7LNARw0aRmKLb+8mxZbzxvB0YQ2_ak5LpcpQy+=3HrtiFA1g@mail.gmail.com>
 <27B16959-58F6-4190-8A65-88FFD2A49452@public-files.de>
 <CAK7LNATk0=gLquyX3W90xcX60O++fhrhjTHJv0k-=vuhGVg5AQ@mail.gmail.com>
X-UI-Message-Type: mail
X-Priority: 3
X-Provags-ID: V03:K1:7MsQe4Z4o2qKNSQCwrVCgmlimcft3+XDKW50jeeM9Mpi4x0Fs/xGyIqUk0igjEpdluoqa
 x5yFSCivZegBLq1/6Lxhqf2I+iTUvGQqf8eS7EJnI8ByjwFJDwQjj3YQkXaVt6TCT+1Igbvuuofm
 QCROoyOgmUFA3vj+xWqp0NfuFEhFhI3q7xW8HZbRhcwWhZ4N7GizO4qgffAK9SV5imiuJCksNTOm
 Nd78PTWH7XD2UhKvgUrCKM/X4rHAfLwaAXtln8EXVeDdeiXXlZyK8KDUSqngCGKOozgS9CGHyY6C
 Fw=
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:kP/ABltPT3Y=:8wJgxmdq6IHQHNCvbZ/eyE
 o8oFPB8qtrHUUgdQATpcfn0bgRS6r9Skc91WOGLHgd2yOHm7xClRxZ2o46v8ebCIYe3txtrwj
 DhO71qebfV1mwJjnRS1AoXWKCwz1+zPcLa9DbwnHJDQZariWUVXjnQlkGURy1+534V8MSd1M7
 7K0f3A/1yIanxC16iOYmDNUxZu2fxKT5xc4liqgEwN1Zs2FRJ+NCMPJI5SXGvpEu8ZCKxq+cZ
 Hvlqtb2iBTnuaAe8F/b8ejPEqBbgwn3yXIrxFapiwJk7iViOq0218ufGe6PYNts55Y/ZSgpRI
 0auN0oT7g4Q1/XjEUBkVAEKGQhcWWFF8SrvSMfJ1Z30NelsyZ5vTpg1OdlMYNJ5d1yGPhdXrx
 lDLLIXpnn5IC2UOZtJw7HjV2IokYV8UzbSKj1HnBbhPB03q6lOwPBw8L3m9/jMHmKBP7cgxW2
 A0tUYFrp0sN+7RCCJIu8eoClT9hTCt9TzPsH1PUq6LhUqwsSzs4ul96bQDQhRUKd7qeyW/tLs
 MDajtbLYo8TEtOqAuWVmdecqQJKfwGtm1JoJDKSBFjano1CS2X4zN3yVrFqzb73gwRo3HDVO6
 516h6eHXeg+bWdG9k56DO/KiWwlHi8RqmBPw/X/Q7T+3VFVX108RHEdRDGnTZeSDS6Enzhonf
 61vPxWujiAfVE+08jHSXqDuW0u7HcnzIm9Ync8WVziHp/j/MeI5VvqB3SzT4Q51/dyJE=
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Gesendet: Dienstag, 15. September 2020 um 09:54 Uhr
> Von: "Masahiro Yamada" <masahiroy@kernel.org>

> On Tue, Sep 15, 2020 at 2:42 PM Frank Wunderlich
> <frank-w@public-files.de> wrote:
> > Yes i exported it before use at beginning of my script [1] and modules=
_install used inside install function [2]. It works with build-function [3=
].

> > [1] https://github.com/frank-w/BPI-R2-4.14/blob/5.9-rc/build.sh#L75
> > [2] https://github.com/frank-w/BPI-R2-4.14/blob/5.9-rc/build.sh#L368
> > [3] https://github.com/frank-w/BPI-R2-4.14/blob/5.9-rc/build.sh#L578
>
> [3] is unrelated since
> "#&& make modules_install 2>&3" is commented out.

i just wanted to point to build-process where KBUILD_OUTPUT is used :)

> In [1], you export KBUILD_OUTPUT as a normal user,
> then in [2], you run the commands with 'sudo'.
>
> That is why KBUILD_OUTPUT was not passed.

thank you very much...i remember why (because the sudo) i passed the vars =
here i already exported ;)

i tried the KERNEL_DIR here (found somewhere but not checked in Makefile),=
 but not the KBUILD_OUTPUT, don't ask me why...with passing KBUILD_OUTPUT =
there all works as expected.

sudo make ARCH=3D$ARCH INSTALL_MOD_PATH=3D$INSTALL_MOD_PATH KBUILD_OUTPUT=
=3D$KBUILD_OUTPUT modules_install

Thanks for pointing to this ;)

regards Frank
