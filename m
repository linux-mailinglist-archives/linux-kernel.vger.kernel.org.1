Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1DDDB209E21
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jun 2020 14:08:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404498AbgFYMIe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Jun 2020 08:08:34 -0400
Received: from mail-ej1-f67.google.com ([209.85.218.67]:45795 "EHLO
        mail-ej1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404222AbgFYMId (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jun 2020 08:08:33 -0400
Received: by mail-ej1-f67.google.com with SMTP id a1so5656087ejg.12
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jun 2020 05:08:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=UKCFODb5/EwXV72SoexoF57zFObV5cMgCmwfT5dAPbA=;
        b=VlkoRLGP6ZTOgAz63/va2pc4PSf7wavjTDUO4sstRpYOE945TOoxkqED4phFOZ+PNf
         N8QJALIMq7qIX2DIearHsXI8eyFXSW6wE+s5X41/sV2pkXK0a+vwgL1o2LznQqhMPeTR
         Lc0ftVp4F+lY+Ee2OoMMgmB/YCFzrn6BR5GSvMXvji5ubIWonqAE/KdaCgGg0kvRfPMP
         mE/yJm1Rldrr1GZN8G7baYFUEotF7P4oOuJ9nqf8i31FTaFmIS8LD2LFsQBDzyeKANtb
         QPjxbY/a66TnpQ+/TOM/RaOk7/3v+dyFK1zbqczraG5PWXfzKCaB6XPTCfMRaL/RAmyn
         DsXQ==
X-Gm-Message-State: AOAM533pY4BZdagNjm7jqeNFLQ0WLtWMNKwk6Li7loeoqMMJ+JZXtwtE
        p2w55+/Srhg4KgYkbaN09Jw=
X-Google-Smtp-Source: ABdhPJyIfSv0VZbZMw3M3h0u082IqoTwW1GoIrLB4k0XxcfIY0wyn5fnLFwQVwhzWD9F/bd4ew1YGA==
X-Received: by 2002:a17:906:c672:: with SMTP id ew18mr30511084ejb.404.1593086911908;
        Thu, 25 Jun 2020 05:08:31 -0700 (PDT)
Received: from localhost (ip-37-188-168-3.eurotel.cz. [37.188.168.3])
        by smtp.gmail.com with ESMTPSA id v24sm3012701eja.29.2020.06.25.05.08.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jun 2020 05:08:31 -0700 (PDT)
Date:   Thu, 25 Jun 2020 14:08:30 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     js1304@gmail.com
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, kernel-team@lge.com,
        Vlastimil Babka <vbabka@suse.cz>,
        Christoph Hellwig <hch@infradead.org>,
        Roman Gushchin <guro@fb.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>
Subject: Re: [PATCH v3 6/8] mm/gup: use a standard migration target
 allocation callback
Message-ID: <20200625120830.GG1320@dhcp22.suse.cz>
References: <1592892828-1934-1-git-send-email-iamjoonsoo.kim@lge.com>
 <1592892828-1934-7-git-send-email-iamjoonsoo.kim@lge.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1592892828-1934-7-git-send-email-iamjoonsoo.kim@lge.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 23-06-20 15:13:46, Joonsoo Kim wrote:
> From: Joonsoo Kim <iamjoonsoo.kim@lge.com>
> 
> There is a well-defined migration target allocation callback.
> It's mostly similar with new_non_cma_page() except considering CMA pages.
> 
> This patch adds a CMA consideration to the standard migration target
> allocation callback and use it on gup.c.

We already can express that by a missing __GFP_MOVABLE so I would rather
not introduce a duplication in form of another flag.
-- 
Michal Hocko
SUSE Labs
