Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 304F71F05E2
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jun 2020 11:03:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728656AbgFFJDJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 Jun 2020 05:03:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:45518 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725283AbgFFJDJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Jun 2020 05:03:09 -0400
Received: from linux-8ccs.fritz.box (p57a23121.dip0.t-ipconnect.de [87.162.49.33])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DD5EB20663;
        Sat,  6 Jun 2020 09:03:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591434188;
        bh=fC/gCpvkFb7u3yKY51L/6vMoxU5Cruln6J8iTYu42ec=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AL8yqJuY2h3fGELtDOe89ZsoWgUiaJOj286fQlvFLG6WJF6/tSd2vOLAVX1aZFjer
         pq5kRLRAbNBGNL27NkQ/fGBsSh///D5TmxE8SuV7a7xAbNmlU5VZRskQrMljPxKt30
         Ix8JHhl9a0loQpwiIcQFOS2ZIOoxiPFWHU2rbMNA=
Date:   Sat, 6 Jun 2020 11:03:05 +0200
From:   Jessica Yu <jeyu@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [GIT PULL] Modules updates for v5.8
Message-ID: <20200606090304.GA11017@linux-8ccs.fritz.box>
References: <20200605093354.GA23721@linux-8ccs.fritz.box>
 <CAHk-=wgNqzQ0CUJ9LP+cLR8FMKwHTqOuSzqvFFKn7Duqquxo1g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <CAHk-=wgNqzQ0CUJ9LP+cLR8FMKwHTqOuSzqvFFKn7Duqquxo1g@mail.gmail.com>
X-OS:   Linux linux-8ccs 4.12.14-lp150.12.61-default x86_64
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+++ Linus Torvalds [05/06/20 13:38 -0700]:
>On Fri, Jun 5, 2020 at 2:34 AM Jessica Yu <jeyu@kernel.org> wrote:
>>
>> Please pull below to receive modules updates for the v5.8 merge window.
>
>Done. Considering the confusion this merge window with the
>dependencies of trees with each other, can you verify that what I got
>matches what you expect?

I reviewed the result of the merge and it matches what I expected. Thank you!
