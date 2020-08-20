Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64F9F24C4DC
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Aug 2020 19:53:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727008AbgHTRxt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Aug 2020 13:53:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725859AbgHTRxl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 13:53:41 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDC13C061385
        for <linux-kernel@vger.kernel.org>; Thu, 20 Aug 2020 10:53:40 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id g6so3039197ljn.11
        for <linux-kernel@vger.kernel.org>; Thu, 20 Aug 2020 10:53:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7Cm21W0ohZmom7e6D74SA9Oqp3/uYQ8Zu3LrYYFjK3Q=;
        b=JSxg4bImHGUfW0cdAyT+bgSlPvjg/mp577Jw/orQ0CYHrpkzK6/oAP2Wj+yQVdM+ug
         ljkr5mGFRCExcB8RA4NWPULgum40XCPwRGsc5byRJEdYiPH0FY19TfKMhX/9HHyWuGlu
         P0GNfV+5flShjCc0A/iYqsE3kT4F66MDtWirU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7Cm21W0ohZmom7e6D74SA9Oqp3/uYQ8Zu3LrYYFjK3Q=;
        b=loFEhKbN/iguQ1IVaz0c9gqaV2+oVIqDXEkSWBDcmC4IhPCIeLV3LANjsqxe8mWdbN
         V9prgiNPsoYVnZlHO3ba7ksSGInHHnc2/WG0YbZ1bM06F/6cM6P38Wd9fd8WlRFC7yWh
         oNUaty3i02GuSp+rdcnh61bv/1M/mxATAUXiHjOyPbzL9bE2OgU+ajRWPxmMyzwkhVn/
         uTgJjYCXbjQf0JHPmpA5nn0CT7GMcB41vsvEIi9OqUKFVUaXL/NVJRThQ3UXd7fvZZfI
         /Djv7VYX/qDd8XYxHYdk2XYKoF6iaZ2D4MFWVDjLBWks3fq4WR1uM056WMV55tzmoWNG
         eJnA==
X-Gm-Message-State: AOAM5319pegZ3okjiJrSakNkD/vdv/JA417hwjzojgG0uGVWv9czS9nN
        Dkzb5LQXeWisu1zDfTq4fTpgpjBK/Ha53Q==
X-Google-Smtp-Source: ABdhPJxh9UiFP/43vWxsy2xbfnko5wYEX7bz/UDF8C+bR+f4/gCcG4qIafrQqKn43oASfXG1i5dQ+A==
X-Received: by 2002:a2e:8098:: with SMTP id i24mr2194676ljg.50.1597946018373;
        Thu, 20 Aug 2020 10:53:38 -0700 (PDT)
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com. [209.85.167.54])
        by smtp.gmail.com with ESMTPSA id t27sm568855ljd.101.2020.08.20.10.53.35
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Aug 2020 10:53:36 -0700 (PDT)
Received: by mail-lf1-f54.google.com with SMTP id k13so1397631lfo.0
        for <linux-kernel@vger.kernel.org>; Thu, 20 Aug 2020 10:53:35 -0700 (PDT)
X-Received: by 2002:a05:6512:3b7:: with SMTP id v23mr2148237lfp.10.1597946015439;
 Thu, 20 Aug 2020 10:53:35 -0700 (PDT)
MIME-Version: 1.0
References: <20200819232632.13418-1-john.ogness@linutronix.de>
 <20200819232632.13418-3-john.ogness@linutronix.de> <CAHk-=wj_b6Bh=d-Wwh0xYqoQBhHkYeExhszkpxdRA6GjTvkRiQ@mail.gmail.com>
 <472f2e553805b52d9834d64e4056db965edee329.camel@perches.com>
In-Reply-To: <472f2e553805b52d9834d64e4056db965edee329.camel@perches.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 20 Aug 2020 10:53:19 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiVd6=XaN1d8qLouWGWHDw6sPz4_VsXjv2OMVAt7rH=cg@mail.gmail.com>
Message-ID: <CAHk-=wiVd6=XaN1d8qLouWGWHDw6sPz4_VsXjv2OMVAt7rH=cg@mail.gmail.com>
Subject: Re: [RFC PATCH 2/5] sysrq: use pr_cont_t for cont messages
To:     Joe Perches <joe@perches.com>
Cc:     John Ogness <john.ogness@linutronix.de>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 20, 2020 at 10:48 AM Joe Perches <joe@perches.com> wrote:
>
> Maybe something like this would be reasonable:

Yes. At this point this improves the code, rather than making it less legible.

              Linus
