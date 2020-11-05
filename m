Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C78C2A7E93
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Nov 2020 13:30:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729832AbgKEMar (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Nov 2020 07:30:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725468AbgKEMaq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Nov 2020 07:30:46 -0500
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BBAAC0613CF
        for <linux-kernel@vger.kernel.org>; Thu,  5 Nov 2020 04:30:46 -0800 (PST)
Received: by mail-lj1-x243.google.com with SMTP id m16so1378695ljo.6
        for <linux-kernel@vger.kernel.org>; Thu, 05 Nov 2020 04:30:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ShvudfQsrLd0EjdiPgpa7UMIQRNiU7jmZnEFRXbGMHA=;
        b=P1XgbaxTDGYAgYuUP4t4ljJGR8TCc11Kb51CPtePOy0tg26wXlS/eWgX7PZIGl6ciT
         cPeEC8IuLGhMxRBeZWVkawam1uWZTAUPVAYDHNM+mQDahinYSpQxnVIz0K1G5DgNnmwk
         mCzdXo23jaG3gjREssvUF9FbBJWrZMmreTwwzP4FTD6gOSxLpCKiQAUGndovIc1GJDwA
         l3fO9k8IcfU4KQYz9ZkpF9vYzTxShoKhW5FNXZ1pN9DzQSDOrBVOYOnsGfV9o2P78LBD
         KP/7a3MdMDPcbEU8Q0wO6LifWP7Ekm7Ox1929CRl9Cz6Af67vWeMWVBJ1EihVqA9XAYa
         WHUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ShvudfQsrLd0EjdiPgpa7UMIQRNiU7jmZnEFRXbGMHA=;
        b=W0S2qS/x0q4aL4e1TqHDT9wPtxrtezEPJvS0RtLXkgluBDlU06Ls43Yu4ITuV36Ubl
         /c8bDyMKtCuWcGP/R+QlHP9X/c82UfHy7ToJBnNyIArd3FFwG7+PMkzk3qsSZ964IrVk
         cOvCYxNoqCKfBfTxvk35luz0KZIRPl54ATWLdMROYz6/VIOlTrqP85SzNzyB+i7wdhG5
         q6mlPRkrMXVdEyaRFLTQmK5x08MPnNVxEtdT/R/GxmbYmh5QNL/6CnHI39hcNvC7zHH5
         SmzPiRBbnYcUMDEWWPKtznltRFych+ykG3DO+zJqAkcLOMfCKQByYW65GxbtpT3McLYo
         4ewQ==
X-Gm-Message-State: AOAM530pJOwqlqknjhBmnXag5pp8ifBHTDR2ZEDum4wi7MEuOFrvNavi
        hbirVuQyXeA+dfulysFCBpTM3v1YjpFOlHbpH6qSVQ==
X-Google-Smtp-Source: ABdhPJzkNMfhYXqZyKhoJXOE/MzxESBDsKd2cYbqk8IlBfAf/Ktg7jzNvXIX8sX58Z9Cr0Yge70kSmIQn2ByJFHnP00=
X-Received: by 2002:a2e:9583:: with SMTP id w3mr854643ljh.25.1604579444748;
 Thu, 05 Nov 2020 04:30:44 -0800 (PST)
MIME-Version: 1.0
References: <1604575253-2386-1-git-send-email-xuewen.yan@unisoc.com>
In-Reply-To: <1604575253-2386-1-git-send-email-xuewen.yan@unisoc.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Thu, 5 Nov 2020 13:30:33 +0100
Message-ID: <CAKfTPtANnayYEOoSvJYvX3F7cv3_rOuFaxGU5K06coTWbxjV-g@mail.gmail.com>
Subject: Re: [PATCH v2] sched: revise the initial value of the util_avg.
To:     Xuewen Yan <xuewen.yan@unisoc.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        xuewen.yan94@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 5 Nov 2020 at 12:22, Xuewen Yan <xuewen.yan@unisoc.com> wrote:
>
> According to the original code logic:
>                 cfs_rq->avg.util_avg
> sa->util_avg  =3D -------------------- * se->load.weight
>                 cfs_rq->avg.load_avg

this should have been scale_load_down(se->load.weight) from the beginning

> but for fair_sched_class:
> se->load.weight =3D 1024 * sched_prio_to_weight[prio];

This is only true for 64bits platform otherwise scale_load and
scale_load_down are nop

>         cfs_rq->avg.util_avg
> so the  -------------------- must be extremely small, the
>         cfs_rq->avg.load_avg
> judgment condition "sa->util_avg < cap" could be established.
> It's not fair for those tasks who has smaller nice value.
>
> Signed-off-by: Xuewen Yan <xuewen.yan@unisoc.com>
> ---
>  kernel/sched/fair.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 290f9e3..079760b 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -794,7 +794,11 @@ void post_init_entity_util_avg(struct task_struct *p=
)
>
>         if (cap > 0) {
>                 if (cfs_rq->avg.util_avg !=3D 0) {

We should now use cpu_util() instead of cfs_rq->avg.util_avg which
takes into account other classes

> -                       sa->util_avg  =3D cfs_rq->avg.util_avg * se->load=
.weight;
> +                       if (p->sched_class =3D=3D &fair_sched_class)
> +                               sa->util_avg  =3D cfs_rq->avg.util_avg * =
se_weight(se);
> +                       else
> +                               sa->util_avg  =3D cfs_rq->avg.util_avg * =
se->load.weight;

Why this else keeps using se->load.weight ?

Either we uses sa->util_avg  =3D cfs_rq->avg.util_avg * se_weight(se);
for all classes

Or we want a different init value for other classes. But in this case
se->load.weight is meaningless and we should simply set them to 0
although we could probably compute a value based on bandwidth for
deadline class

> +
>                         sa->util_avg /=3D (cfs_rq->avg.load_avg + 1);
>
>                         if (sa->util_avg > cap)
> --
> 1.9.1
>
> ________________________________
>  This email (including its attachments) is intended only for the person o=
r entity to which it is addressed and may contain information that is privi=
leged, confidential or otherwise protected from disclosure. Unauthorized us=
e, dissemination, distribution or copying of this email or the information =
herein or taking any action in reliance on the contents of this email or th=
e information herein, by anyone other than the intended recipient, or an em=
ployee or agent responsible for delivering the message to the intended reci=
pient, is strictly prohibited. If you are not the intended recipient, pleas=
e do not read, copy, use or disclose any part of this e-mail to others. Ple=
ase notify the sender immediately and permanently delete this e-mail and an=
y attachments if you received it in error. Internet communications cannot b=
e guaranteed to be timely, secure, error-free or virus-free. The sender doe=
s not accept liability for any errors or omissions.
> =E6=9C=AC=E9=82=AE=E4=BB=B6=E5=8F=8A=E5=85=B6=E9=99=84=E4=BB=B6=E5=85=B7=
=E6=9C=89=E4=BF=9D=E5=AF=86=E6=80=A7=E8=B4=A8=EF=BC=8C=E5=8F=97=E6=B3=95=E5=
=BE=8B=E4=BF=9D=E6=8A=A4=E4=B8=8D=E5=BE=97=E6=B3=84=E9=9C=B2=EF=BC=8C=E4=BB=
=85=E5=8F=91=E9=80=81=E7=BB=99=E6=9C=AC=E9=82=AE=E4=BB=B6=E6=89=80=E6=8C=87=
=E7=89=B9=E5=AE=9A=E6=94=B6=E4=BB=B6=E4=BA=BA=E3=80=82=E4=B8=A5=E7=A6=81=E9=
=9D=9E=E7=BB=8F=E6=8E=88=E6=9D=83=E4=BD=BF=E7=94=A8=E3=80=81=E5=AE=A3=E4=BC=
=A0=E3=80=81=E5=8F=91=E5=B8=83=E6=88=96=E5=A4=8D=E5=88=B6=E6=9C=AC=E9=82=AE=
=E4=BB=B6=E6=88=96=E5=85=B6=E5=86=85=E5=AE=B9=E3=80=82=E8=8B=A5=E9=9D=9E=E8=
=AF=A5=E7=89=B9=E5=AE=9A=E6=94=B6=E4=BB=B6=E4=BA=BA=EF=BC=8C=E8=AF=B7=E5=8B=
=BF=E9=98=85=E8=AF=BB=E3=80=81=E5=A4=8D=E5=88=B6=E3=80=81 =E4=BD=BF=E7=94=
=A8=E6=88=96=E6=8A=AB=E9=9C=B2=E6=9C=AC=E9=82=AE=E4=BB=B6=E7=9A=84=E4=BB=BB=
=E4=BD=95=E5=86=85=E5=AE=B9=E3=80=82=E8=8B=A5=E8=AF=AF=E6=94=B6=E6=9C=AC=E9=
=82=AE=E4=BB=B6=EF=BC=8C=E8=AF=B7=E4=BB=8E=E7=B3=BB=E7=BB=9F=E4=B8=AD=E6=B0=
=B8=E4=B9=85=E6=80=A7=E5=88=A0=E9=99=A4=E6=9C=AC=E9=82=AE=E4=BB=B6=E5=8F=8A=
=E6=89=80=E6=9C=89=E9=99=84=E4=BB=B6=EF=BC=8C=E5=B9=B6=E4=BB=A5=E5=9B=9E=E5=
=A4=8D=E9=82=AE=E4=BB=B6=E7=9A=84=E6=96=B9=E5=BC=8F=E5=8D=B3=E5=88=BB=E5=91=
=8A=E7=9F=A5=E5=8F=91=E4=BB=B6=E4=BA=BA=E3=80=82=E6=97=A0=E6=B3=95=E4=BF=9D=
=E8=AF=81=E4=BA=92=E8=81=94=E7=BD=91=E9=80=9A=E4=BF=A1=E5=8F=8A=E6=97=B6=E3=
=80=81=E5=AE=89=E5=85=A8=E3=80=81=E6=97=A0=E8=AF=AF=E6=88=96=E9=98=B2=E6=AF=
=92=E3=80=82=E5=8F=91=E4=BB=B6=E4=BA=BA=E5=AF=B9=E4=BB=BB=E4=BD=95=E9=94=99=
=E6=BC=8F=E5=9D=87=E4=B8=8D=E6=89=BF=E6=8B=85=E8=B4=A3=E4=BB=BB=E3=80=82
