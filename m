Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 885A8286122
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Oct 2020 16:23:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728606AbgJGOXO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Oct 2020 10:23:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:46047 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728053AbgJGOXO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Oct 2020 10:23:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1602080593;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=arCJetUQyffSDjg12W9Bfh+TxnVKzaBR2KG2Ej+1vzg=;
        b=RFXeIrZgSUJLdo3RlpVWwZrZ/BQYNMZBT8lq8bpvakjQAoAHT9QAZAoO3SWzOKb+REHQ4B
        6k8QDC+JAw9Wj5LaSa1wCkzBB2+Vo6z6P4aprdU+/lM0VQj87EehP+W47fDFJ1PSpc5jmB
        CEs03sza5XapTTSnA+7qhkthzZYqCR4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-236-yazGlPxIPsy3s1B2I8T-qg-1; Wed, 07 Oct 2020 10:23:11 -0400
X-MC-Unique: yazGlPxIPsy3s1B2I8T-qg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2DD8E10857E8;
        Wed,  7 Oct 2020 14:23:09 +0000 (UTC)
Received: from ovpn-66-246.rdu2.redhat.com (ovpn-66-246.rdu2.redhat.com [10.10.66.246])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 51433757DF;
        Wed,  7 Oct 2020 14:23:04 +0000 (UTC)
Message-ID: <a52f0536059b795c0841c2ae0c65a607f2ce558a.camel@redhat.com>
Subject: Re: [PATCH v2 09/11] powerpc/smp: Optimize update_mask_by_l2
From:   Qian Cai <cai@redhat.com>
To:     Srikar Dronamraju <srikar@linux.vnet.ibm.com>
Cc:     Michael Ellerman <mpe@ellerman.id.au>,
        Nathan Lynch <nathanl@linux.ibm.com>,
        Gautham R Shenoy <ego@linux.vnet.ibm.com>,
        Michael Neuling <mikey@neuling.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Oliver O'Halloran <oohall@gmail.com>,
        Satheesh Rajendran <sathnaga@linux.vnet.ibm.com>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Ingo Molnar <mingo@kernel.org>
Date:   Wed, 07 Oct 2020 10:23:03 -0400
In-Reply-To: <20201007141745.GM12031@linux.vnet.ibm.com>
References: <20200921095653.9701-1-srikar@linux.vnet.ibm.com>
         <20200921095653.9701-10-srikar@linux.vnet.ibm.com>
         <f848a6761de05d655d847130e77b23b2bb39aa26.camel@redhat.com>
         <20201007141745.GM12031@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2020-10-07 at 19:47 +0530, Srikar Dronamraju wrote:
> Can you confirm if CONFIG_CPUMASK_OFFSTACK is enabled in your config?

Yes, https://gitlab.com/cailca/linux-mm/-/blob/master/powerpc.config

We tested here almost daily on linux-next.

