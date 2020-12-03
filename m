Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 395C22CD06D
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Dec 2020 08:31:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728666AbgLCHaz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Dec 2020 02:30:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727391AbgLCHay (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Dec 2020 02:30:54 -0500
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B23BC061A4D
        for <linux-kernel@vger.kernel.org>; Wed,  2 Dec 2020 23:30:14 -0800 (PST)
Received: by mail-ej1-x642.google.com with SMTP id qw4so1908877ejb.12
        for <linux-kernel@vger.kernel.org>; Wed, 02 Dec 2020 23:30:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uZ/XGNhtoOQrbENqOXJbu4NnR/IRF+nt0tG8EtU2v4I=;
        b=Tq1U7R+X70S6sorF7X/KkMiXAVcBgEQf0ajgS8vbuO8pbtBPun+qlqfqyXgPYbXw6z
         zpNPffrdEd2gjOGgCBg9AKuzGkybuFJJWd1b8YXQ7GyE2KHQpixtaUH+QxcEw5aGeEh3
         GjdVVGb3WBSnO8LjfKtqr+TgBSRmezjO7rqC6vTsoXybvqxUNtKhKRx/fwwrWjiX4OSm
         P/YI68cIMhg63SMk3O+/W0rps639oYAZwk/LLuiaLah2zFRrOnslp+YDiEZplRauHC4Y
         dX5cDVXgyDIeRPQI+qKkgZe5WiG5NhlO+Su5nvAc6RsD/uT+ljwORtxpWNi51tCjhrn3
         L3GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uZ/XGNhtoOQrbENqOXJbu4NnR/IRF+nt0tG8EtU2v4I=;
        b=lziStt8MYz5CSplA7nuHLqYoyTGAm/6ywcjt81UdJchehi3Gci21lR25bbd4MRIER1
         AezduPtKMlwpCmPD7tr20SQrsWtC5AwbUDFzmhrMaVfbFfA2HNepwisuogfW/EgGgHXO
         4jvP68dlPX8XBUnlRUp/KM7fPp56LE16mV971P+iLA/Vi8IiWzle8fQduRkrolv47cIc
         t5ak2auKUA9eeEbXduusivupXUkrsO5JgCy926cvB5T07bGIpk0TMSLle5bEm+uLsQAO
         8epPyCJNaHOJFKVnNO+aDDoEVRoPDavXJs9pWo45RFTLOymkDN8suJap38s2MVR9j0/Z
         OACQ==
X-Gm-Message-State: AOAM5339ogRozUm00GJIyzV+ubd2BJs6h4b38IkyiGFeDT7dAejmCB7e
        6/1DVIzCm/AVVhxrSeUsc5wYNZgSYY2S9FknWB6mJcSJ2xo=
X-Google-Smtp-Source: ABdhPJzTsqA1rfc92cAYTkf57FsuAL7Dw1HRXwlK1u0yIS+ME4QKtBT73sHLxujSE+yX3ZTjaGxdY8+t7f2NR9ttvEg=
X-Received: by 2002:a17:906:ed2:: with SMTP id u18mr1355857eji.1.1606980612906;
 Wed, 02 Dec 2020 23:30:12 -0800 (PST)
MIME-Version: 1.0
References: <20201203064826.30832-1-tesheng@andestech.com>
In-Reply-To: <20201203064826.30832-1-tesheng@andestech.com>
From:   Pekka Enberg <penberg@gmail.com>
Date:   Thu, 3 Dec 2020 09:29:57 +0200
Message-ID: <CAOJsxLHo6-6w9M3H1UP1hPX1bnxZ06tqbnc9cwR5_sLQBgA7HA@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] Let illegal access to user-space memory die
To:     Eric Lin <tesheng@andestech.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Michel Lespinasse <walken@google.com>,
        Vlastimil Babka <vbabka@suse.cz>, Peter Xu <peterx@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Christoph Hellwig <hch@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Eric,

On Thu, Dec 3, 2020 at 8:51 AM Eric Lin <tesheng@andestech.com> wrote:
>
> Accesses to user-space memory without calling uaccess routine
> leads to hanging in page fault handler. Like arm64, we let it
> die earlier in page fault handler.
>
> Changes in v2:
>     -Add a die_kernel_fault() helper
>     -Split one long line code into two

Please also make no_context() use the new helper. Other than that:

Reviewed-by: Pekka Enberg <penberg@kernel.org>
