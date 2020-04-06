Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BF2CA19F21C
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Apr 2020 11:11:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726873AbgDFJLF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Apr 2020 05:11:05 -0400
Received: from mx2.suse.de ([195.135.220.15]:36862 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726663AbgDFJLF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Apr 2020 05:11:05 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 16907AC7B;
        Mon,  6 Apr 2020 09:11:04 +0000 (UTC)
Date:   Mon, 6 Apr 2020 11:11:03 +0200 (CEST)
From:   Miroslav Benes <mbenes@suse.cz>
To:     Julien Thierry <jthierry@redhat.com>
cc:     linux-kernel@vger.kernel.org, jpoimboe@redhat.com,
        peterz@infradead.org
Subject: Re: [PATCH] objtool: Fix off-by-one in symbol_by_offset()
In-Reply-To: <20200403131730.32618-1-jthierry@redhat.com>
Message-ID: <alpine.LSU.2.21.2004061110450.26870@pobox.suse.cz>
References: <20200403131730.32618-1-jthierry@redhat.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 3 Apr 2020, Julien Thierry wrote:

> Sometimes, WARN_FUNC() and other users of symbol_by_offset() will
> associate the first instruction of a symbol with the symbol preceding
> it.
> This is because symbol->offset + symbol->len is already outside of the
> symbol's range.
> 
> Signed-off-by: Julien Thierry <jthierry@redhat.com>

Reviewed-by: Miroslav Benes <mbenes@suse.cz>

