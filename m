Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B010328F540
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Oct 2020 16:51:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389414AbgJOOvZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Oct 2020 10:51:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389055AbgJOOvJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Oct 2020 10:51:09 -0400
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BD7BC0613D2
        for <linux-kernel@vger.kernel.org>; Thu, 15 Oct 2020 07:51:09 -0700 (PDT)
Received: by mail-lf1-x144.google.com with SMTP id a9so3929096lfc.7
        for <linux-kernel@vger.kernel.org>; Thu, 15 Oct 2020 07:51:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bV4f1Qg+4Gv35N2wit/f7NjVpNxZdd3YNwQ6SWe/ma0=;
        b=OYat1tu/tT4xPSTOsQRpW6iStW0f2RAvrVqZM2wKYQ5qUpvTlkK0tW9fFDuKWCuYbx
         Ncv0Ts6rNHB0uqaIpNXIlQ0S7DkES1kA/yhljcF4/ynUIzo2tM/o87WVzk1bRBbjMP4B
         cSDdjZaLugIPplKKgZSVVV3mPnKPKuLVd8WksM8JbCG0OUG/fF4UUP3GMaKhdlwT/+zV
         HsXGKLICg97DrPVSd3rJxLq7PJBzjYNu3PyZJmM3JVfYKMvtP01owdX2hLVjWhsfVufr
         +rj+v3YZWE2VDHu65ilvtRlhbs8cnQqPZdBP9vlMVxEzgioF/fPt6CY7wLSadZ3WeNds
         7rrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bV4f1Qg+4Gv35N2wit/f7NjVpNxZdd3YNwQ6SWe/ma0=;
        b=gnaI1Vt4YTCa+X/QCUZxO4IiE+NgQQ7xSkmefWpD1rpbjWNZS6A914c7t3wAjQiz2V
         utub7oBWhk/PJd72IhhSq/jKF6NTe0Z+em0Fo18YB6vP7mNXlLs+KqWcNlu8E2vsgCmn
         LJASmWIjEFK84Ur4tiHj68zNLfTq9MmnJT59VIcjxsPbO4y4uo6XsIXY1aJWkDLLRnsr
         OBAgyvx/3XNf93sU7H8Z+b2++RuGZe1MVnESI8KX9Ulvy0ebeE4C6kSvB4reKhvldUSL
         7I/yT4XFGdQ+Q+Mdklj8uAIPUvZM/phpG8yu8fa+/Y3K6vu1KdE2bYXWbBYB3OpkZIBo
         29Pg==
X-Gm-Message-State: AOAM530wbvOt5rbzLLlAv6RFv69/DHsIQoFcps0wg5ocYL8RUNwKVFIt
        OKzb0dKYKrzhaAVpDBABF9dsyYhPfpdQtGjMnz4=
X-Google-Smtp-Source: ABdhPJz4cz6ryROltTYzKnZPApyMbINiaXN8B0RTQpbg1uR4m85nIpOyOyacfPQKPIETr+/AP5JTkJuMVSaTsmdK8zM=
X-Received: by 2002:ac2:52b7:: with SMTP id r23mr1126232lfm.30.1602773467610;
 Thu, 15 Oct 2020 07:51:07 -0700 (PDT)
MIME-Version: 1.0
References: <20201014175342.152712-1-jandryuk@gmail.com> <20201014175342.152712-3-jandryuk@gmail.com>
 <6cd9363c-ac0c-ea68-c8e7-9fd3cd30a89b@oracle.com> <4e31301b-0e57-ac89-cd71-6ad5e1a66628@citrix.com>
 <b097aec1-e549-a89a-ce43-e9c0a71179f2@oracle.com>
In-Reply-To: <b097aec1-e549-a89a-ce43-e9c0a71179f2@oracle.com>
From:   Jason Andryuk <jandryuk@gmail.com>
Date:   Thu, 15 Oct 2020 10:50:55 -0400
Message-ID: <CAKf6xpuRZKF56yyOR-Q6oBSJUpRSr0P+XVJD7DvaS6GWnNcMTg@mail.gmail.com>
Subject: Re: [PATCH 2/2] xen: Kconfig: nest Xen guest options
To:     Boris Ostrovsky <boris.ostrovsky@oracle.com>
Cc:     Andrew Cooper <andrew.cooper3@citrix.com>,
        Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        xen-devel <xen-devel@lists.xenproject.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 15, 2020 at 9:17 AM <boris.ostrovsky@oracle.com> wrote:
>
>
> On 10/15/20 9:10 AM, Andrew Cooper wrote:
> > On 15/10/2020 13:37, boris.ostrovsky@oracle.com wrote:
> >> On 10/14/20 1:53 PM, Jason Andryuk wrote:
> >>> +config XEN_512GB
> >>> +   bool "Limit Xen pv-domain memory to 512GB"
> >>> +   depends on XEN_PV && X86_64
> >> Why is X86_64 needed here?
> >> 512G support was implemented using a direct-mapped P2M, and is rather
> > beyond the virtual address capabilities of 32bit.
> >
>
> Yes, my point was that XEN_PV already depends on X86_64.

Oh, thanks for catching this.  I re-introduced it by accident when
rebasing the patches.

Regards,
Jason
