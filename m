Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B03926E5B3
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Sep 2020 21:56:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726751AbgIQTzx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Sep 2020 15:55:53 -0400
Received: from mout.kundenserver.de ([212.227.126.135]:42487 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727831AbgIQO4a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Sep 2020 10:56:30 -0400
Received: from mail-lj1-f178.google.com ([209.85.208.178]) by
 mrelayeu.kundenserver.de (mreue009 [212.227.15.129]) with ESMTPSA (Nemesis)
 id 1MXp1Q-1k06J73QwW-00YBtl; Thu, 17 Sep 2020 16:56:05 +0200
Received: by mail-lj1-f178.google.com with SMTP id c2so2282441ljj.12;
        Thu, 17 Sep 2020 07:56:05 -0700 (PDT)
X-Gm-Message-State: AOAM531gOuxw6B3HMibCIs7c5PN5vP97LgwXiV1TDUs5+Seel9FGAZx9
        a0mOk6rbITsT3rYNCzNm+zcSies232Zt5I5qGlw=
X-Google-Smtp-Source: ABdhPJyXAeW/X/vUfrjW8LIX+29c3f5FGDUd17W9rK9Pn/Vi9uZ/dih0ocJwvfWpmI4GGWt1IoC+QnOz/UhV92idazI=
X-Received: by 2002:a2e:b161:: with SMTP id a1mr9630509ljm.189.1600354565212;
 Thu, 17 Sep 2020 07:56:05 -0700 (PDT)
MIME-Version: 1.0
References: <20200908213715.3553098-1-arnd@arndb.de> <20200908213715.3553098-3-arnd@arndb.de>
 <20200912074757.GA6688@infradead.org> <CAK8P3a363DxgZnN9x4oNL7W4__kyG1U_34=7Hpqhpc-obAvjWw@mail.gmail.com>
 <20200913065051.GA17932@infradead.org> <CAK8P3a3W1EYts=2uL-6kTWwcgBeigLdv-W4mnxBd+En2ZFReLA@mail.gmail.com>
In-Reply-To: <CAK8P3a3W1EYts=2uL-6kTWwcgBeigLdv-W4mnxBd+En2ZFReLA@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 17 Sep 2020 16:55:49 +0200
X-Gmail-Original-Message-ID: <CAK8P3a2r=-JQLyVeLhFvDtWrdtJN_pWsPHRoi5VHcgfK0SbQ5g@mail.gmail.com>
Message-ID: <CAK8P3a2r=-JQLyVeLhFvDtWrdtJN_pWsPHRoi5VHcgfK0SbQ5g@mail.gmail.com>
Subject: Re: compat_alloc_user_space removal, was Re: [PATCH 3/3] scsi:
 megaraid_sas: simplify compat_ioctl handling
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Kashyap Desai <kashyap.desai@broadcom.com>,
        Sumit Saxena <sumit.saxena@broadcom.com>,
        Shivasharan S <shivasharan.srikanteshwara@broadcom.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Anand Lodnoor <anand.lodnoor@broadcom.com>,
        Chandrakanth Patil <chandrakanth.patil@broadcom.com>,
        Hannes Reinecke <hare@suse.de>, megaraidlinux.pdl@broadcom.com,
        linux-scsi <linux-scsi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:U4pNn/L9pBqEnn0uQRl1oAnkE71gwgvZK+cqa3vHgq8KSmYiB3E
 3KsKvUbLCuC0cmbjsajD/C/Dt2B4vv1nf5tvHv/NsSJ5O/EZctPiMwkp7QCg1+IbBlFfjIM
 5W9TyvIpjBQkWYg8eWIfKLvX5vfsAmAtbOYJHmFEBaZFe4CyEJsvRaLFMEa83jUpoz8t1JG
 aNOECUm/UcrC8imlucwow==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:j4G9oaZuUec=:cs2qoMLvlXb69ZsotlH/5Q
 WEJLBZj368+1qLsYmbHXlq9IkfZvrZc9n9f7y9jtE6ASej0k4mI9ZHO+jz+wkQkmOB0hpU3DD
 as+mM6nbgIMK+YxfBJCnWmaaavRxkBOPcaq1w+6HfNqcaLIIZ0dJOoVUjk2ZKKRlVr26ODoJG
 S/NeMWKhqeNzxvESlp4BQCdr41WGQsAOxVwBA7qxG/KKeDZE7KBPNP3TJVi4F7Cpef6TGI12c
 PFizI6RQo/SN+vqNU59pOvH+tqJMhVQdC+acJUwPvgPvPddLy2SlwczGlghFcKQJEjBafee7w
 kc+f4L/bCZanu51WOXu8i0Q0b+mM6d+/duDxleF1T4AJy/iRN3ojqhJWqhuibuGrxJirgItBO
 Uk1UF9aLI2XA+J5Xv/AFPDHNAiwXwRWW4vXY87t6LAVGk+C5abgYwPXodYj2mny0dORTcbfLx
 jY/ryYlEVt0gEgtivb0m6o+G50eKv5KEmSrx9ea9gg4QR2rBbuP+1T/srF5lng+1zyOX03zvX
 WRrToJS539DMgb7WS21zZEhlcefeJ8yK+/xaZlzLb+eoAGfOy0kAVj66SvoX6eaLp6PbdAv3J
 4QXdNt//01B2WgvdH3B7HUEFa9dukcsr+tTig0fdXactaF8lK1vbj2L60YelbeAxmJTKvye2z
 WtAI3NrqRKlF3IeefHlnM6HDznBfgwboVv2X51nRfv+zgITb9KgHS4YyXFd4lYaIqujUuZvuz
 ajtUnp1h0nmPhayFVuC4sCwVO5YXiahRgBMn1XVz2xFtlOGMHnIXxTP/HsJI6asIvwdMxaG0s
 5RBTb0VWkACvPIHlwh5hdNjoShte0Ey3a4/oVzvKiADZ7ukIrVJK5YOzOTYcKAFH57yuOEi8k
 V+zu+vKwHq9ySW/fLw2LPujW5cPbcmQNi4e0FTLHpld3enusE5UCC/xUzi4tS57CjyTb/IjPg
 Sz4e818dMgJL2lf6BaOLlZssEOnaApABNGQtKBkJsMT5HDaioGXG+
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 13, 2020 at 1:46 PM Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Sun, Sep 13, 2020 at 8:50 AM Christoph Hellwig <hch@infradead.org> wrote:
> >
> > On Sat, Sep 12, 2020 at 02:49:05PM +0200, Arnd Bergmann wrote:
> > > fs/quota/compat.c: dqblk = compat_alloc_user_space(sizeof(struct if_dqblk));
> > > fs/quota/compat.c: dqblk = compat_alloc_user_space(sizeof(struct if_dqblk));
> > > fs/quota/compat.c: fsqstat = compat_alloc_user_space(sizeof(struct
> > > fs_quota_stat));
> >
> > I sent this out a while ago, an Al has it in a branch, but not in
> > linux-next:
> >
> > https://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git/log/?h=work.quota-compat
>
> Nice! Aside from already being queued, your patch is also nicer than
> my version, and it makes it trivial to fix it for arm oabi as well by adding
>
> #ifdef CONFIG_OABI_COMPAT
> #define compat_need_64bit_alignment_fixup in_oabi_syscall
> #endif
>
> to arch/arm/include/asm/compat.h
>
> I had considered fixing that case for arch/arm as well but it ended up being
> harder to do in my version.

Unfortunately, the commit b902bfb3f0e "arm64: stop using <asm/compat.h>
directly" seems to introduce a circular header file inclusion between
linux/compat.h and asm/stat.h, breaking arm64 compilation.

Moving the compat_u64/compat_s64 definitions to include/asm-generic/compat.h
works fine though.

      Arnd
