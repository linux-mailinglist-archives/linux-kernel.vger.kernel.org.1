Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54F1A2978AC
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Oct 2020 23:10:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755343AbgJWVKZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Oct 2020 17:10:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752266AbgJWVKZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Oct 2020 17:10:25 -0400
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com [IPv6:2607:f8b0:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54F89C0613CE
        for <linux-kernel@vger.kernel.org>; Fri, 23 Oct 2020 14:10:25 -0700 (PDT)
Received: by mail-ot1-x343.google.com with SMTP id e20so2578851otj.11
        for <linux-kernel@vger.kernel.org>; Fri, 23 Oct 2020 14:10:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ymCmJTooyNdL1EqF0pjKK4EeKCNVf3sxNXseKAntLks=;
        b=SgGdzCIM9osaG0ky/Dn1c01P5XE9EBK2cScEBQuUiz/osI+jK/49RRGupO9Xv3rxW+
         IEU2CstR7jq6a90p61j8Jcl4NIG4BkGK47Gv7ImkjPaWHgr0aNZzrKiOVKCVnrkzLwhp
         cQv8uqohtTcITy0zRMmPgUjgno4JMC+ioxY56H7vggbrboz7fRM4yehZ08zCltOWC5kr
         yBMJhWc+iNdGz0pi3qaUOMsQrKrYAVPoYHFc45boIU4GYGL0GdSd0y/9y4TXPmWosqPC
         kmETOtVNCz9qnahyuIUh4wH4l0bjfKuBqJWn1sHMku9A1Z6XVC01N9cWLH1czBcMEy1U
         xNCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ymCmJTooyNdL1EqF0pjKK4EeKCNVf3sxNXseKAntLks=;
        b=lKpP0lphT4U1wNR4Rdj2oWoNcYDDiuCYHJoATLMMI7cY5a/Uv8XMxkEFAZL3zGISko
         /uQxouEB2M6I4jzNWjQRKV+GsSA2/qiD2LCREpsnoVjBBnliCidqHnGGR0wjiDtP6aWK
         0wcH9yc85reempoLpNM2cob1Oes5dzYE91cteg6QJawl5BHlkJg1pd2Jq8yobKgzw4/N
         MT8xAjfJsjWvVv4zC9ASDC9fJg1RUw5jap3Pn67sQ3joKiT0OyIDnADm62XHRWX6G6ME
         2dmoqwHbx8fWDygrEL3mD8QLxuryz4TrgPTuCdNXaok59uo8zWVPEPmudHpCPb3JX9YB
         vrYg==
X-Gm-Message-State: AOAM533d20GQn7ov88dK+M7dMdcZsn9NfZIXTYLXj/ZcbgO6CjfS5M2L
        uR1HsxG9YkQiLWumKh6mHk5iGZggZAQRavMLPAbyHGGVklbXsA==
X-Google-Smtp-Source: ABdhPJz4qNwKWDma5pGy66C5m2BYX1dI/OdUywP3C7yjlamQOd24uLp8vrjmNSmoldjPUKH6WfU867AJN+QD9k0EYZI=
X-Received: by 2002:a9d:53cc:: with SMTP id i12mr3028527oth.215.1603487424607;
 Fri, 23 Oct 2020 14:10:24 -0700 (PDT)
MIME-Version: 1.0
References: <20201023094307.20820-1-dwaipayanray1@gmail.com>
 <d2b05b45adbcf3f1d16692b054862a7aa7353f6d.camel@perches.com>
 <CABJPP5Dx4qj-_0gOx0bmaWvJj3okB-tNGJg5-8Y3KF2LnCjowQ@mail.gmail.com>
 <2e8279841d604dde8a3335c092db921007f6744e.camel@perches.com>
 <2a3b90ee-b9bd-2586-9d68-45cbf7e499a9@gmail.com> <8710630d8c01bf6f3749e3d11d193a805f2d2048.camel@perches.com>
 <CABJPP5AcjAq0kg0MMggd2D6YUwVhq96otm-qQB3Snddt77VxAA@mail.gmail.com> <4317722a8dc93b6de1dc974a8cb51c7f22d86ecf.camel@perches.com>
In-Reply-To: <4317722a8dc93b6de1dc974a8cb51c7f22d86ecf.camel@perches.com>
From:   Dwaipayan Ray <dwaipayanray1@gmail.com>
Date:   Sat, 24 Oct 2020 02:39:55 +0530
Message-ID: <CABJPP5BWRWFd=fUMMuWE7R3+w-y_6i9uxK=jZFVijZ8xWThT2Q@mail.gmail.com>
Subject: Re: [PATCH RFC v2] checkpatch: extend attributes check to handle more patterns
To:     Joe Perches <joe@perches.com>
Cc:     linux-kernel-mentees@lists.linuxfoundation.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 24, 2020 at 2:34 AM Joe Perches <joe@perches.com> wrote:
>
> On Sat, 2020-10-24 at 02:27 +0530, Dwaipayan Ray wrote:
> > Also I tried the pattern  attr =~ s/^_*(.*)_*$/$1/
> > for trimming the _ earlier. I think it doesn't trim the
> > trailing underscores in the suffix as (.*) captures everything greedily.
> >
> > Is the iterative one perhaps okay instead?
> > while($attr =~ s/(.*)_$/$1/) {}
>
> Then perhaps
>
>         $curr_attr =~ s/^_+//; $curr_attr =~ s/_+$//;
>
Okay thanks!
I will send in a new version when everything looks good
and tested.

Regards,
Dwaipayan.
