Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99F912009A4
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jun 2020 15:13:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732425AbgFSNNL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Jun 2020 09:13:11 -0400
Received: from mail-wr1-f45.google.com ([209.85.221.45]:44782 "EHLO
        mail-wr1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726124AbgFSNNJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 09:13:09 -0400
Received: by mail-wr1-f45.google.com with SMTP id b6so9632721wrs.11
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jun 2020 06:13:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/6fVd8/rN7MHG3zvTKeKPFhmmlDHpXzdpSC6EWMceGA=;
        b=YgFrALzvWPPR5N8dBOhzkJLFa2XbSSisPrLpP/0Zf6BdCgAUmMFMwLcr65kMs6spth
         Fswxb9UxEXhxKd68P/6JmARfBXIGlwxGjoonIhJuC+XOZkCBQv7DpFigT819yIh3WDXU
         a2pbjrT1BkLqO1YcIUVxJBroFv8dhZSKAUv3XrPs15ZE797nnoqVv88cDIhJKSIhHEgA
         E8dAMDoT5EzUfJuGEa+86sWTpMQJVWBKtq9RoMzLzQdPLoUrv2BsKjH2lymOuqz/SLNL
         3zhYKfO92mqixWqPN6wl3OJRCsUk1CfGpihD3IZLKJZW6F6BtcJBtdeTiPzLafyIOwkq
         GnMQ==
X-Gm-Message-State: AOAM531c2BhUHgVFa0GaDoCNMASBCM8PQnA/TJZAJelJtgamlEyV0Jgv
        /zP/21AWVT1QdHkfYtBNFC1eVhx7y4ZWP3KzDFk=
X-Google-Smtp-Source: ABdhPJyXMi/Tm9XvlRMx29RASMiVDmtUJYuuu7BUYcmI0UY0exkkxm+D0Hirf281UdQj3WODU+U/1Yb12PwUmja+oBA=
X-Received: by 2002:a5d:428e:: with SMTP id k14mr4072363wrq.21.1592572387702;
 Fri, 19 Jun 2020 06:13:07 -0700 (PDT)
MIME-Version: 1.0
References: <20200618003916.26644-1-gaurav1086@gmail.com> <CAM9d7ciTTJ5e0JjrK0K7y5034kTQ08tcfvJ7wry6yY8O0BGDxg@mail.gmail.com>
 <CAFAFadA3rRQxw9nyGnhn7kshRfQ_2AN+d-eCwHF-HJ_bYfYVog@mail.gmail.com>
In-Reply-To: <CAFAFadA3rRQxw9nyGnhn7kshRfQ_2AN+d-eCwHF-HJ_bYfYVog@mail.gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Fri, 19 Jun 2020 22:12:56 +0900
Message-ID: <CAM9d7cgX4v+sBnpd3r1h+MO-U5mNYsAg7JN_O56h=sjjZPhy9g@mail.gmail.com>
Subject: Re: [PATCH] [perf] Fix null pointer deference in nest_epollfd
To:     gaurav singh <gaurav1086@gmail.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Tommi Rantala <tommi.t.rantala@nokia.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "open list:PERFORMANCE EVENTS SUBSYSTEM" 
        <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 19, 2020 at 6:28 AM gaurav singh <gaurav1086@gmail.com> wrote:
>
> multiqu is a static bool which is never assigned and nested is a static int (=0)

It's set by command line option (-m).

Thanks
Namhyung


> and only assigned in nest_epollfd(). Hence,
>
>         if (nested)
>             nest_epollfd(NULL);
>
> probably never gets executed.
