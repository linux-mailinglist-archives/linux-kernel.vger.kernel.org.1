Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B72E71F3732
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jun 2020 11:44:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728552AbgFIJoQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Jun 2020 05:44:16 -0400
Received: from mx2.suse.de ([195.135.220.15]:53544 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726964AbgFIJoN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jun 2020 05:44:13 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id BEF78AD4A;
        Tue,  9 Jun 2020 09:44:15 +0000 (UTC)
Date:   Tue, 9 Jun 2020 11:44:11 +0200 (CEST)
From:   Miroslav Benes <mbenes@suse.cz>
To:     Julien Thierry <jthierry@redhat.com>
cc:     linux-kernel@vger.kernel.org, jpoimboe@redhat.com,
        peterz@infradead.org, mhelsley@vmware.com
Subject: Re: [PATCH v2 0/4] Remove dependency of check subcmd upon orc
In-Reply-To: <20200608071203.4055-1-jthierry@redhat.com>
Message-ID: <alpine.LSU.2.21.2006091143470.13900@pobox.suse.cz>
References: <20200608071203.4055-1-jthierry@redhat.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 8 Jun 2020, Julien Thierry wrote:

> Hi,
> 
> Matt Helsley's change[1] provided a base framework to opt-in/out
> objtool subcommands at compile time. This makes it easier for
> architectures to port objtool, one subcommand at a time.
> 
> Orc generation relies on the check operation implementation. However,
> the way this is done causes the check implementation to depend on the
> implementation of orc generation functions to call if orc generation is
> requested. This means that in order to implement check subcmd, orc
> subcmd also need to be implemented.
> 
> These patches aim at removing that dependency, having orc subcmd
> being built on top of the check subcmd.
> 
> Changes since v1 [2]:
> - Remove redundant check in create_orc pointed out by Miroslav
> 
> [1] https://www.spinics.net/lists/kernel/msg3510844.html
> [2] https://lkml.org/lkml/2020/6/4/675

Reviewed-by: Miroslav Benes <mbenes@suse.cz>

M
