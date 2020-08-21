Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81ED924D67F
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Aug 2020 15:47:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729023AbgHUNrO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Aug 2020 09:47:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729008AbgHUNrD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Aug 2020 09:47:03 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CD39C061573
        for <linux-kernel@vger.kernel.org>; Fri, 21 Aug 2020 06:47:02 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id si26so2311874ejb.12
        for <linux-kernel@vger.kernel.org>; Fri, 21 Aug 2020 06:47:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=OCNzDue0d+9gLeuNDZrCDBO7b3B7dWV+FryyxTem/wM=;
        b=BDf9azafY0usvDzD6SWESmOB5PViNnJj/9/rufIn6pIb+SY+E3IMtw8WgrrAe16c4D
         4N8dFgKM6uDJ5zMAeHRHVh2MspW7Vyqt4+RMuWrtXCAaCTzuLDaaynS6Xh7n16Druirz
         jcpfkpFlm4VZpqGAv6FeR4sQcbKFoxcUoI9PiSQp2IX8EAvR6ej9RtSNHVACLazukIfV
         nmyeHO03NRVFJEKHpywQOu/goM180NbO31Wc3qb2ZZwR3x3+nzZBtDf2svECy09qT82G
         mwkkIc7GZ9nPEBr821KMJE0RuuapIE4o0Co9wpwdrldJBb6eTDutPhyuviqb3sI1SyIC
         7SaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=OCNzDue0d+9gLeuNDZrCDBO7b3B7dWV+FryyxTem/wM=;
        b=W5FLqPsyWQAD5ILgAQ7LSD2wcY9lSXu3HJmeYZcE/Nhvs7HDLEM9mQqYiz2706PDZd
         6G5AkLX6jcC0p/SFMx4GIf0SbxDYAIuq/n0Qc3SaQ+VZc7ysmxa3syraon4pY+/mnput
         r3Wvyo1wk4Ay4EdAXmt+x8TyW+El9VlkWClyqXTaDwqWPBrfu4e1jKmbSS40WXwemlk/
         EVZKuu9fIFaAl13h4HcE4nlkMu60xaIV5gxBQSqkT8ffRUOFW0IkKtCS9bpzVj3PbLCS
         HKqDxW50qW70MuD34vrJW0VZsOd2wy3nDFD/eISgzCm3gnws9sPDtIeEXHF0pynhcqvP
         I1LA==
X-Gm-Message-State: AOAM530sbacbztMnYTeCCDpjGgTEEaK+EqoLgbj1/lv3HR4kJ3xZp4Nh
        shf73SryvhNue8vaQRxJJQVuX+TZaQ2N6H0XKVes
X-Google-Smtp-Source: ABdhPJy6zIIVIwF1GHspiGxBu6rQjz/cqHvYRzEm2Z4xJYFQGvRzpYb/UmjUqCMgmnE906lKpJCPOKo+BUF7LdsX8Lo=
X-Received: by 2002:a17:906:e0e:: with SMTP id l14mr2792528eji.398.1598017621287;
 Fri, 21 Aug 2020 06:47:01 -0700 (PDT)
MIME-Version: 1.0
References: <20200817170729.2605279-1-tweek@google.com> <20200817170729.2605279-4-tweek@google.com>
 <0bb62de9-1020-a7c4-3a7f-48ae2f78e3b7@gmail.com> <20200817162933.79f69c66@oasis.local.home>
 <20200818120948.1a428da9@oasis.local.home> <66e6d84e-20b5-1bd3-e107-322f42ce35d3@gmail.com>
 <20200820223136.162850ce@oasis.local.home> <CAEjxPJ7-6PaHjPzB7vN=nh+VMNV-T2bnKM-YrXdQwOzNtG+9zg@mail.gmail.com>
 <CAHC9VhTLOWsD9LbVGBj=o3N3SPe-uJDvrdQAySy6MmE4uyuzng@mail.gmail.com> <CA+zpnLfNjDwxgoG2p3W8YfXxYVQDum4Eh_MJQvKP4rGLqsqACA@mail.gmail.com>
In-Reply-To: <CA+zpnLfNjDwxgoG2p3W8YfXxYVQDum4Eh_MJQvKP4rGLqsqACA@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Fri, 21 Aug 2020 09:46:50 -0400
Message-ID: <CAHC9VhRXZXiYFX20wtMt9bTv-6sAer91gY1x5ueJv4fa-i5jPA@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] selinux: add permission names to trace event
To:     =?UTF-8?Q?Thi=C3=A9baud_Weksteen?= <tweek@google.com>
Cc:     Stephen Smalley <stephen.smalley.work@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Nick Kralevich <nnk@google.com>,
        Peter Enderborg <peter.enderborg@sony.com>,
        Eric Paris <eparis@parisplace.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Rob Herring <robh@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 21, 2020 at 9:21 AM Thi=C3=A9baud Weksteen <tweek@google.com> w=
rote:
>>
>> I'm okay with merging patches 1/3 and 2/3 wth the changes Stephen
>> suggested, but I think we will need to leave patch 3/3 out of this for
>> now.
>
> That works for me.

Can you respin patches 1 and two with those changes and repost?  I try
to refrain from making non-merge-fuzz changes when merging patches.

--=20
paul moore
www.paul-moore.com
