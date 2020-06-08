Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5D8C1F1F4D
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jun 2020 20:50:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726166AbgFHSu2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Jun 2020 14:50:28 -0400
Received: from ex13-edg-ou-002.vmware.com ([208.91.0.190]:58774 "EHLO
        EX13-EDG-OU-002.vmware.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726105AbgFHSu0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jun 2020 14:50:26 -0400
Received: from sc9-mailhost3.vmware.com (10.113.161.73) by
 EX13-EDG-OU-002.vmware.com (10.113.208.156) with Microsoft SMTP Server id
 15.0.1156.6; Mon, 8 Jun 2020 11:50:24 -0700
Received: from localhost (unknown [10.188.145.109])
        by sc9-mailhost3.vmware.com (Postfix) with ESMTP id 6B38A4051D;
        Mon,  8 Jun 2020 11:50:25 -0700 (PDT)
Date:   Mon, 8 Jun 2020 11:50:24 -0700
From:   Matt Helsley <mhelsley@vmware.com>
To:     Julien Thierry <jthierry@redhat.com>
CC:     <linux-kernel@vger.kernel.org>, <jpoimboe@redhat.com>,
        <peterz@infradead.org>, <mbenes@suse.cz>
Subject: Re: [PATCH v2 2/4] objtool: Move orc outside of check
Message-ID: <20200608185024.GB1284251@rlwimi.vmware.com>
Mail-Followup-To: Matt Helsley <mhelsley@vmware.com>,
        Julien Thierry <jthierry@redhat.com>, linux-kernel@vger.kernel.org,
        jpoimboe@redhat.com, peterz@infradead.org, mbenes@suse.cz
References: <20200608071203.4055-1-jthierry@redhat.com>
 <20200608071203.4055-3-jthierry@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20200608071203.4055-3-jthierry@redhat.com>
Received-SPF: None (EX13-EDG-OU-002.vmware.com: mhelsley@vmware.com does not
 designate permitted sender hosts)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 08, 2020 at 08:12:01AM +0100, Julien Thierry wrote:
> Now that the objtool_file can be obtained outside of the check function,
> orc generation builtin no longer requires check to explicitly call its
> orc related functions.
> 
> Signed-off-by: Julien Thierry <jthierry@redhat.com>

Reviewed-by: Matt Helsley <mhelsley@vmware.com>

> ---
>  tools/objtool/builtin-check.c |  2 +-
>  tools/objtool/builtin-orc.c   | 18 +++++++++++++++++-
>  tools/objtool/check.c         | 16 +---------------
>  tools/objtool/objtool.h       |  2 +-
>  tools/objtool/weak.c          |  2 +-
>  5 files changed, 21 insertions(+), 19 deletions(-)
