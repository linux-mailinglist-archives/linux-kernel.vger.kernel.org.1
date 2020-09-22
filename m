Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8659C273D55
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Sep 2020 10:32:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726812AbgIVIcZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Sep 2020 04:32:25 -0400
Received: from mout.kundenserver.de ([212.227.126.134]:58423 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726799AbgIVIcZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Sep 2020 04:32:25 -0400
Received: from mail-qk1-f182.google.com ([209.85.222.182]) by
 mrelayeu.kundenserver.de (mreue010 [212.227.15.129]) with ESMTPSA (Nemesis)
 id 1MEmMt-1kEGs81ae3-00GF4a; Tue, 22 Sep 2020 10:32:23 +0200
Received: by mail-qk1-f182.google.com with SMTP id o16so18182762qkj.10;
        Tue, 22 Sep 2020 01:32:23 -0700 (PDT)
X-Gm-Message-State: AOAM533M20kxEgvelf/VO+G9X2qrPUXUIqjvXRf6CJ6JVUgscSJ9tmhq
        JI95lCQxj6CI5nua3kZed4+m5KjIy13WYE8FuIM=
X-Google-Smtp-Source: ABdhPJxVpm81rzuOpNNfOHDEBf6+tjIbpNILGqrTgab5VBp9jlR3YGmn4XYZi/VkOVydTRkIPBWlkQmdh650kLrWwZs=
X-Received: by 2002:a05:620a:15a7:: with SMTP id f7mr3478911qkk.3.1600763542109;
 Tue, 22 Sep 2020 01:32:22 -0700 (PDT)
MIME-Version: 1.0
References: <20200922024302.205062-1-matheus@castello.eng.br>
 <20200922024302.205062-5-matheus@castello.eng.br> <20200922061454.GA29035@Mani-XPS-13-9360>
In-Reply-To: <20200922061454.GA29035@Mani-XPS-13-9360>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 22 Sep 2020 10:32:06 +0200
X-Gmail-Original-Message-ID: <CAK8P3a0yGN80nJU0kcrvYGsSjpaNpU_nmu-ENwE3GMC_9DNBhg@mail.gmail.com>
Message-ID: <CAK8P3a0yGN80nJU0kcrvYGsSjpaNpU_nmu-ENwE3GMC_9DNBhg@mail.gmail.com>
Subject: Re: [PATCH v7 4/4] arm64: dts: Add Caninos Loucos Labrador v3
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     Matheus Castello <matheus@castello.eng.br>,
        Olof Johansson <olof@lixom.net>,
        =?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>, edgar.righi@lsitec.org.br,
        igor.lima@lsitec.org.br, Helen Koike <helen.koike@collabora.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        DTML <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-actions@lists.infradead.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:+Sqw26Y1nKBMFvEKEpYY9XOxck/gdND6fjiQ4kFxp4wbP7bFlGM
 kuRZyB+2geuCCT/rxiFsTXGnEmvSM8b4lMu5MrChP5IBHn7kKo75YJmLGxBAixtlM8WAU0d
 d+v74Xe19vj2tlcGguoZE1cDXdN8LGvOiuDaCm+bTGxnOJQCY0FXBpp9WNaHGOkTVFNR4fx
 Og1A/15kIKcOAubqYCKAw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:ydvbePANNgc=:1XqGMU9MMzy78mwQnLt3Nt
 KT0R3TVIy5ON5Z/7/at1FUKmFiQc9cYeJIUx+/GJ4HxfKQAsaKdYcdlotDv0z4AnR7zeV5k5b
 MNn8boFU7kkciZv4FlhCCznM9nbhtcWUhebBeJbIrDN2/T+n3R3BcJmeS76In9VdgJVBdYS3q
 8VdcolAcJ2MK41+fK/YV1EoRXfI7FqC5KqD97joTK0TKd2f6YhZIPZGQzSB2vsTZWqZRr0hP2
 R8xfPAz/3ouNEyyQHWGgPwnMEZju0UDGS3Qu0rq7A0jxH2mQg52l+duYWFsD/spiXKa5ynXca
 rwCV91AHuaLl/uwWfhVmLOT3f4HJxKCaziqgBaY3Dmbjnrnh7uoTIU1b6vxHIJXKzohJnGkN6
 SZdPvGr9gzDii76sssP0+xZeE7D7DyAFDXmn0kXLdKIVJQESR2kDitbjIWsF7JAqJiBNYWfr4
 1VXbnaGyegIxdimQAeN/gvRmeJ9ETRvlevJh1Xj3+/BnotCyt9fXHAZ0Yzymcp7XfhPo5j3DY
 VPsilAKt0dlFbsyCJurey8zzfFLfpRwnf/bTKVeTCkGKlZic2qQ2kg70FyOQGGE5dyVPQbCsa
 rqfolmPCEM+vHwUSB38IfPUpCkW/9mLxVp8uHM/1sbiniouHoQNglWm6nR1qvmarfEj/tQwOX
 wSQOL+0fWrVIXaBiN1sXkJ0VAMkKe5pzTqmaJDgsU3/ZuvYugyyv34I6CWn6L+QCqELrDnyKE
 WEgpzu57xho/Ga7MvtXaXD/h5NqaQ9zHtNrnvF8RvvsJwYnnViC9bwKajWChGL69ANMz2oMqA
 aehPrTxa7zovaAHX77VYWfx52f7C1u4NY5oIS4W3oNCIfr9HmOY9XlWyHgDWln0d+iCNLUUNo
 taoWjhXPafxCeeNh8KU+j4nbfh5BnAHWYUUahkAw3ggp2bCqkqlM9FLTKxAn0NZTIcJQhZzrm
 LG33hMlblv+GotRHshi074FPe+hnLbbdWykAsB8qMla1I/V1+BFWX
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 22, 2020 at 8:15 AM Manivannan Sadhasivam
<manivannan.sadhasivam@linaro.org> wrote:
> On Mon, Sep 21, 2020 at 11:43:02PM -0300, Matheus Castello wrote:
> > +     /* Labrador v3 firmware does not support PSCI */
>
> Oops. This is unfortunate... I'm not sure if this is even acceptable for
> ARM64 machines.
>
> Let me add Olof and Arnd...

Adding Catalin and Will for additional input as well, this is more their
area than ours.

I don't think we have formalized this as a policy, but we clearly don't
want new boards to use the spin table hack. As there are other
boards using psci on the same chip, I don't think this is a
hardware bug.

Matheus: can you explain what keeps you from fixing the
bootloader instead?

      Arnd
