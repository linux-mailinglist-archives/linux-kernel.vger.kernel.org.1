Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 626B028E193
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Oct 2020 15:45:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731367AbgJNNo6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Oct 2020 09:44:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:58152 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726459AbgJNNo5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Oct 2020 09:44:57 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A9B842076D;
        Wed, 14 Oct 2020 13:44:55 +0000 (UTC)
Date:   Wed, 14 Oct 2020 09:44:53 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Cc:     Zamir SUN <sztsian@gmail.com>, Tony Jones <tonyj@suse.de>,
        Jiri Olsa <jolsa@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Trace Devel <linux-trace-devel@vger.kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        "Ziqian SUN (Zamir)" <zsun@redhat.com>,
        Vitaly Chikunov <vt@altlinux.org>,
        Tzvetomir Stoyanov <tstoyanov@vmware.com>,
        Yordan Karadzhov <ykaradzhov@vmware.com>,
        Ben Hutchings <ben@decadent.org.uk>,
        John Kacur <jkacur@redhat.com>,
        Clark Williams <williams@redhat.com>,
        Al Stone <ahs3@debian.org>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Subject: Re: [ANNOUNCE] libtraceevent.git
Message-ID: <20201014094453.73f37dd4@gandalf.local.home>
In-Reply-To: <CADVatmM2hsbZ64Zr=5KES-iPyoxicmm+zkvxTZMq49eWQ390yw@mail.gmail.com>
References: <20201007130750.49349844@gandalf.local.home>
        <20201012101208.GF1099489@krava>
        <20201012111950.55a73588@gandalf.local.home>
        <20201012184120.GN13697@suse.de>
        <20201012151732.6e439886@gandalf.local.home>
        <CAHnb8o61XwvgkMnryaOv-=qCDf-o5OpezQAAk-44R+KgCc8Vcw@mail.gmail.com>
        <20201013090228.78256290@gandalf.local.home>
        <CADVatmM2hsbZ64Zr=5KES-iPyoxicmm+zkvxTZMq49eWQ390yw@mail.gmail.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 14 Oct 2020 11:08:48 +0100
Sudip Mukherjee <sudipm.mukherjee@gmail.com> wrote:

> Just a thought, if you see
> https://repology.org/project/linux-tools/versions then you will notice
> that libtracevent has been packaged by the distros with a version of
> v5.x+, and I will have the same problem for Debian also. Do you think
> it makes sense to start  with a version of v6.x when you tag it? If
> that is not possible then we will have to use epoch like we did for
> libbpf.

Grumble. This is another reason I wish this was not part of the kernel. It
should not have a versioning based on the kernel. Yeah, this may be an
issue, especially, since library versions have real meaning with respect
to compatibility, where the Linux kernel version numbers do not.

We may need to use the epoch on this, because 5.7 has no meaning compared
to 5.8 and 5.9. I didn't even realize this was being shipped yet.

Yeah, I want to make this 1.1.0 as I've been tracking changes internally
with this.

-- Steve
