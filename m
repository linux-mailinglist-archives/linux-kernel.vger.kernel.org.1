Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE1663029B2
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jan 2021 19:12:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731344AbhAYSLr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jan 2021 13:11:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731384AbhAYSEO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jan 2021 13:04:14 -0500
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82A52C061794
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jan 2021 10:03:34 -0800 (PST)
Received: by mail-pl1-x632.google.com with SMTP id s15so8123420plr.9
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jan 2021 10:03:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1pJ/Zg4ITbpnJw71WkGTelTq5ONDoCLkdhBdvVCe5i4=;
        b=k+KsWO2X4iS3aQW0u2AustK5TvQV3i7HDSLpoN2SKTpgi2Cg1iDN3/xQWKhErdpfg7
         QHVwRoJHJi9HP1UDsT1vPCaYjFAvbL7/w0refH8FvCVOfCSmaBZQVF7xcpuygh5BJG/h
         zeImed+1NT7e9sv9w1rcprQaGeQMIpTfJyHbCU24COqaNF4pubMfYHdIUBPajTTB9obw
         Ki40OU0c1SsW5Y/uaREqbLRNwDT3q/hkhxGYzwPjRB4SkcuD56axUKkS59J8q2jr+WvS
         a5xqHXyzy+Bl/sa8FJGv+7eJ8uHrkGLPrAZiO9o9KXthrQHHXF6wbMWbLDKciwrSdyFO
         oFZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1pJ/Zg4ITbpnJw71WkGTelTq5ONDoCLkdhBdvVCe5i4=;
        b=QY+p8NoxtkGEk7TR9tHYRooQRU53sH3+LQ0VRHtJ8/wCzLa3rJZq1k0xOpVW+0DHnO
         qfozkkXRxYbzVegRzk8YaFSdnPNuNtm6H/ygtYKt6eVPm5LojDkI2oZ4LhSObDuErfZ5
         XHnYe6uJvqyjSj89ujrThXZ9dlq1NO3IkcGo9LZiMjyOH+ujuyROgMKx8XnC/9Bc1kP1
         aaxhYZHY5paaNjDzi8OnKPDpKXPuWjFszse/Un1YPJ6io6TYAK7xlDGbd4EneDMxu6lb
         pK8w2vVWYWTxsvoHiJAEM18yZLngdbnFmEV/DtxOBlsTN/IgnmahphYDaqogM/FQ5UEg
         uX9Q==
X-Gm-Message-State: AOAM53053UBpkpDelbGCMKm+3qKcdX9Vd1anEeOMqitgN5fsFfWyuvbt
        UGzVPapx0tyFuiTZxpTb7vUkHhBnHDN/+84CFt/xLw==
X-Google-Smtp-Source: ABdhPJxhTFp/J1wD7mLm9mReeYAHLE1jxITaDZV7Ek3501Dq5sv45lD9qOFynyiG2hL1//FGjgYTzzNjuYIJhIUamkw=
X-Received: by 2002:a17:902:aa8b:b029:da:ef22:8675 with SMTP id
 d11-20020a170902aa8bb02900daef228675mr1620975plr.15.1611597813990; Mon, 25
 Jan 2021 10:03:33 -0800 (PST)
MIME-Version: 1.0
References: <20210125111223.2540294c@canb.auug.org.au>
In-Reply-To: <20210125111223.2540294c@canb.auug.org.au>
From:   Arjun Roy <arjunroy@google.com>
Date:   Mon, 25 Jan 2021 10:03:23 -0800
Message-ID: <CAOFY-A0_f_fbj_+7HN-sBh5H97_HciW=yBRMnw5kvwYsvjyhBg@mail.gmail.com>
Subject: Re: linux-next: manual merge of the bpf-next tree with the net-next tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>,
        David Miller <davem@davemloft.net>,
        Networking <netdev@vger.kernel.org>,
        Jakub Kicinski <kuba@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Stanislav Fomichev <sdf@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 24, 2021 at 4:12 PM Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>
> Hi all,
>
> Today's linux-next merge of the bpf-next tree got a conflict in:
>
>   net/ipv4/tcp.c
>
> between commit:
>
>   7eeba1706eba ("tcp: Add receive timestamp support for receive zerocopy.")
>
> from the net-next tree and commit:
>
>   9cacf81f8161 ("bpf: Remove extra lock_sock for TCP_ZEROCOPY_RECEIVE")
>
> from the bpf-next tree.
>
> I fixed it up (see below) and can carry the fix as necessary. This
> is now fixed as far as linux-next is concerned, but any non trivial
> conflicts should be mentioned to your upstream maintainer when your tree
> is submitted for merging.  You may also want to consider cooperating
> with the maintainer of the conflicting tree to minimise any particularly
> complex conflicts.
>

The fix looks good, thank you.

-Arjun

> --
> Cheers,
> Stephen Rothwell
>
> diff --cc net/ipv4/tcp.c
> index e1a17c6b473c,26aa923cf522..000000000000
> --- a/net/ipv4/tcp.c
> +++ b/net/ipv4/tcp.c
> @@@ -4160,18 -4098,13 +4160,20 @@@ static int do_tcp_getsockopt(struct soc
>                 if (copy_from_user(&zc, optval, len))
>                         return -EFAULT;
>                 lock_sock(sk);
>  -              err = tcp_zerocopy_receive(sk, &zc);
>  +              err = tcp_zerocopy_receive(sk, &zc, &tss);
> +               err = BPF_CGROUP_RUN_PROG_GETSOCKOPT_KERN(sk, level, optname,
> +                                                         &zc, &len, err);
>                 release_sock(sk);
>  -              if (len >= offsetofend(struct tcp_zerocopy_receive, err))
>  -                      goto zerocopy_rcv_sk_err;
>  +              if (len >= offsetofend(struct tcp_zerocopy_receive, msg_flags))
>  +                      goto zerocopy_rcv_cmsg;
>                 switch (len) {
>  +              case offsetofend(struct tcp_zerocopy_receive, msg_flags):
>  +                      goto zerocopy_rcv_cmsg;
>  +              case offsetofend(struct tcp_zerocopy_receive, msg_controllen):
>  +              case offsetofend(struct tcp_zerocopy_receive, msg_control):
>  +              case offsetofend(struct tcp_zerocopy_receive, flags):
>  +              case offsetofend(struct tcp_zerocopy_receive, copybuf_len):
>  +              case offsetofend(struct tcp_zerocopy_receive, copybuf_address):
>                 case offsetofend(struct tcp_zerocopy_receive, err):
>                         goto zerocopy_rcv_sk_err;
>                 case offsetofend(struct tcp_zerocopy_receive, inq):
