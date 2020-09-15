Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 182D126ACBF
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Sep 2020 20:58:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727873AbgIOS6q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Sep 2020 14:58:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727928AbgIOS5l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Sep 2020 14:57:41 -0400
Received: from mail-vs1-xe44.google.com (mail-vs1-xe44.google.com [IPv6:2607:f8b0:4864:20::e44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F3C9C06174A
        for <linux-kernel@vger.kernel.org>; Tue, 15 Sep 2020 11:57:41 -0700 (PDT)
Received: by mail-vs1-xe44.google.com with SMTP id y190so2548339vsy.1
        for <linux-kernel@vger.kernel.org>; Tue, 15 Sep 2020 11:57:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=posk.io; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6iXFFj/7ZUvX7XyypdlyCYEl/6h4et7lVvH8K/NN6VA=;
        b=T2lQW/481b7kgPVDGjkvC5eLU6vgL7uH+JU7QtyQ11DTdW5JZx5H63O8ifl5idzaJN
         40XhbIDOS4fThmXgbCUetV9IeII2bECWLYeZ98Fiy0Mel2qClzKT1Yk61NV8n9W5hGSt
         MLptBRiqBeoi9axT3NpiKkMjrWnj1H/yi8YNHSd4touHj4yClW0REFrvnxywmyRTaoEz
         zyCPjmlfKgPjnw0qHzX/tUEcv86Gf5uTv9zCgyxX/MHIwn8V9004lVUZ8Ps/G+h7Gwbl
         Cf2abAmALXW4jHEW7G6XrMXjvx2kU9/NyIz0NVQYp8f2TEoa0OU1l0oA8BjjTOv2WKwb
         HBIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6iXFFj/7ZUvX7XyypdlyCYEl/6h4et7lVvH8K/NN6VA=;
        b=NDmTPyzILa1eyXFaGeHfpt/9xaTBlAd6Mcs3oAIYF+pgmA4S003jGJJs/LQYDjO0Um
         PWBgHBTWcSNrTeYXpRgMV1SPqnTs5yv2ta43wkK0kSFCstUunvp8sMlyPm9og/HgHI3X
         0xlY1Ri83pGuakcKGQ6QJs+IGonuIb3VtA2mIqR4OrMkSGq1ziISdj/SxnBQPGZpd7se
         RBknc00RB5p5UF06Kc9uGBn0EUxzRzbrCZOLD7v7Gy/Yhu7YrA7y7c3874SoQnm2x8OJ
         m/S9Nbc9B/Bt0oId+MSB9qOx8aSMQ/xKOtpEWUz3MIZokyd9EE8tb8UVVzpodnWn1TBB
         Ei6Q==
X-Gm-Message-State: AOAM530noZbvNz3gyVLFyd4jQD3GjRak9Ol4Pi3TXBLEXtScrEaH1h2L
        +xisHKHniUcvAWOKli8DRfXbcQaWXVVdfYGBHKyFEA==
X-Google-Smtp-Source: ABdhPJxXF5r2HqaLbL2aeJB4a8Im/TdqEDpE3zeFJdTCPa1a+snpD5i2D32445PuCsghNPTZe5KVDP9VQBCM8LKINXM=
X-Received: by 2002:a67:fc48:: with SMTP id p8mr2562113vsq.53.1600196259856;
 Tue, 15 Sep 2020 11:57:39 -0700 (PDT)
MIME-Version: 1.0
References: <20200831225810.2287294-1-posk@google.com> <CAFTs51WPjmEk2nQaxPAgOLN+3E7rfCVQ_=Q6PwD7dS2wyAKu5w@mail.gmail.com>
 <1071966201.11729.1600184387644.JavaMail.zimbra@efficios.com>
In-Reply-To: <1071966201.11729.1600184387644.JavaMail.zimbra@efficios.com>
From:   Peter Oskolkov <posk@posk.io>
Date:   Tue, 15 Sep 2020 11:57:29 -0700
Message-ID: <CAFTs51V=u1S4HuMn7WZEMJBRL79sUVT1g_9JcHqx4bW6zuyh4g@mail.gmail.com>
Subject: Re: [PATCH 1/2 v6] rseq/membarrier: add MEMBARRIER_CMD_PRIVATE_EXPEDITED_RSEQ
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc:     Peter Oskolkov <posk@google.com>, paulmck <paulmck@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Paul Turner <pjt@google.com>,
        Chris Kennelly <ckennelly@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 15, 2020 at 8:39 AM Mathieu Desnoyers
<mathieu.desnoyers@efficios.com> wrote:
>
> ----- On Sep 15, 2020, at 2:12 AM, Peter Oskolkov posk@posk.io wrote:
>
> > Any comments here? Should I change anything?
>
> See below,

Thanks for the review - all done in V7. Please have a look.

Thanks,
Peter

[...]
