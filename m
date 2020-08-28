Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37934255781
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Aug 2020 11:24:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728941AbgH1JYl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Aug 2020 05:24:41 -0400
Received: from mx2.suse.de ([195.135.220.15]:45812 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728954AbgH1JYZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Aug 2020 05:24:25 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id D7CA6AC6F;
        Fri, 28 Aug 2020 09:24:56 +0000 (UTC)
Date:   Fri, 28 Aug 2020 11:24:23 +0200 (CEST)
From:   Miroslav Benes <mbenes@suse.cz>
To:     Julien Thierry <jthierry@redhat.com>
cc:     linux-kernel@vger.kernel.org, jpoimboe@redhat.com,
        peterz@infradead.org, benh@kernel.crashing.org
Subject: Re: [PATCH v4 4/4] objtool: check: Use orc definition only when
 needed
In-Reply-To: <20200825124742.29782-5-jthierry@redhat.com>
Message-ID: <alpine.LSU.2.21.2008281117030.29208@pobox.suse.cz>
References: <20200825124742.29782-1-jthierry@redhat.com> <20200825124742.29782-5-jthierry@redhat.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 25 Aug 2020, Julien Thierry wrote:

> Implementation of ORC requires some definitions that are currently
> provided by the target architecture headers. Do not depend on these
> definitions when the orc subcommand is not implemented.
> 
> This avoid requiring arches with no orc implementation to provide dummy
> orc definitions.
> 
> Signed-off-by: Julien Thierry <jthierry@redhat.com>

This is definitely simpler than what v3 had.

Reviewed-by: Miroslav Benes <mbenes@suse.cz>

M
