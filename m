Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD0AC29BF12
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Oct 2020 18:01:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1814919AbgJ0RAd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Oct 2020 13:00:33 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:42215 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1814885AbgJ0RAZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Oct 2020 13:00:25 -0400
Received: by mail-lf1-f67.google.com with SMTP id a7so3228521lfk.9
        for <linux-kernel@vger.kernel.org>; Tue, 27 Oct 2020 10:00:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JOkOQdeAZBKXehea/I+LV660yUEr8YowhbHHyrQKP+k=;
        b=BkAA9TpPQ80fpLOQAsxuO2McRglQ4sZIr18E6vJdK16Z4+CEynFp3HA/KNAGejf4xN
         ofhlZG1se4q+R8J4SDBTz482eUNLdrmW/05+seBM1UxLmIhv00x1ICeH+0Z1VL0V8Jhf
         xCMKnEXiJjaaOoI53CKz5rJk+dwF5ple/Kgwg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JOkOQdeAZBKXehea/I+LV660yUEr8YowhbHHyrQKP+k=;
        b=dAkp4yQXH+7oQkhzvYPwT3rBV4443/OOpywp7EvOJUE3ci4JLgzB6j3ostUDDJyBum
         4r349HVyMISvdXfKN1xoEvQQlZjhTR19B92uzNXiYgetGCK/H1ZuMG0P898Scixvs41b
         ndZhxpPbWcQL/tMbE+yUZ3PQTe1Gci4/LpDTJFJL7w1kMkC9NupiAyK5U3u5vd9Uz+Gb
         05L3Tbm1Oept0M2HwdpAQIZUWZ/Z+vvXGCEJYmszgJXSiJSqF+HAsDDL+K7c76qSYEOW
         GxVz1v9TqwTKc1in5WlxxVkG2bxegB51yCczTqZeAtDkJ19NuCX9UkOI52Cz8WcmBwZg
         xtsA==
X-Gm-Message-State: AOAM533o6g24rrthaZvRLx6CL2DeY1KJSPFlmWzDZPkv1Lj9skqgXKYI
        fPZ8wpEsNU+pduwm3D0QEXXZg8fNWppEoQ==
X-Google-Smtp-Source: ABdhPJyYFL0zUROZ4kEUdc+HjZaBw8kNMnXJ9Vtr8JUXkQEPF6BNiMw6r5ytAusw/db5+bWhZ87eeQ==
X-Received: by 2002:a19:4bc9:: with SMTP id y192mr1139605lfa.447.1603818022743;
        Tue, 27 Oct 2020 10:00:22 -0700 (PDT)
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com. [209.85.167.41])
        by smtp.gmail.com with ESMTPSA id r9sm245827ljh.75.2020.10.27.10.00.19
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Oct 2020 10:00:22 -0700 (PDT)
Received: by mail-lf1-f41.google.com with SMTP id h6so3289703lfj.3
        for <linux-kernel@vger.kernel.org>; Tue, 27 Oct 2020 10:00:19 -0700 (PDT)
X-Received: by 2002:a19:4815:: with SMTP id v21mr1314225lfa.603.1603818018994;
 Tue, 27 Oct 2020 10:00:18 -0700 (PDT)
MIME-Version: 1.0
References: <f69575e0-5170-2d51-8d74-8b3453723aa3@kernel.dk>
 <20201027000920.GE3576660@ZenIV.linux.org.uk> <20201027080135.GB22650@lst.de>
In-Reply-To: <20201027080135.GB22650@lst.de>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 27 Oct 2020 10:00:03 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjKhAhOF6Q5JX6a3gdcmZjFFYcBJ-JJ6wybSMHdn2M_Xg@mail.gmail.com>
Message-ID: <CAHk-=wjKhAhOF6Q5JX6a3gdcmZjFFYcBJ-JJ6wybSMHdn2M_Xg@mail.gmail.com>
Subject: Re: [PATCH] Fix compat regression in process_vm_rw()
To:     Christoph Hellwig <hch@lst.de>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, Jens Axboe <axboe@kernel.dk>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Kyle Huey <me@kylehuey.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 27, 2020 at 1:01 AM Christoph Hellwig <hch@lst.de> wrote:
>
> Independent of this fix I think we just need to explicitly prohibit
> cross-access.

Well, prohibiting a 32-bit process from accessing a 64-bit one might
make sense, since it fundamentally cannot work, and returning an
explicit error early might help avoid confusion.

But a 64-bit one can certainly validly look at a 32-bit one (ie
debugging a compat process from a 64-bit gdb or similar is not
unreasonable).

That said, I wonder how muich of a problem that can be, so it may be
sufficient to just fix this compat case up and leave it alone.

So applied,

            Linus
