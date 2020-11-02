Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6C522A35F5
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Nov 2020 22:25:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726670AbgKBVZH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Nov 2020 16:25:07 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:40862 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725933AbgKBVZH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Nov 2020 16:25:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1604352306;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=2Snpjj32EZfd5zmVNHpW7WN3b1s9Tl7X56oVsWAnz9o=;
        b=AWgpB5KPhu0LDr3wYpiBNFvlMN262ty29Xld/f1KZCPmQcmWoJQrdfTMJoWx1gMdjU5XB/
        JGxgz/gJ8dcbhoL70+e+Wd3KTEHWXLR+cCrnxZy2AHCFZCHay2an0+6sUc00OLv6gyO3yp
        85Yoas5NBn5WhSTGe9yVI/Tsarh9sBk=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-3-qOwc5KOcMoG9E6hdN2VdSw-1; Mon, 02 Nov 2020 16:25:04 -0500
X-MC-Unique: qOwc5KOcMoG9E6hdN2VdSw-1
Received: by mail-qv1-f71.google.com with SMTP id j17so5929257qvi.21
        for <linux-kernel@vger.kernel.org>; Mon, 02 Nov 2020 13:25:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=2Snpjj32EZfd5zmVNHpW7WN3b1s9Tl7X56oVsWAnz9o=;
        b=AMRT3hw+9HEFqA/Ck7IU/i2VFJ5aa+H0H728BryRoIBPzs+vWYOox5uwGB2Ue26t/T
         6umWh8nQhZ093c0u6vHG1CSf1hFC9bqQI1PtFm/j9jCU6KntY28cAnThwvau6NDBWRwd
         OoTgKaEarHuIJTsd6ge7htJ0FJqUHyPMEwLfBQDYIZuAVq+x9WmvyWvOGbb2kBtBJmva
         UqjeE0nW7z0DQ/Urs/NuVLoKXO2R6etYcv+Mf65Z1oj1PKJ9jmF7wYoN6/93zHx3tKS8
         yluhehOOvPLSLI3mOhjTWjQwCQUba6E1Svyz1ZZKREY/1ZTTxsA+VIyFrJIXS+Ftu1v6
         jzHQ==
X-Gm-Message-State: AOAM531VB9SRoox57kzYD/Xjp2Ab5Aat8CizQv7/HJRruKv3VCf1vcVh
        fnrcsiWX7xguk04FQ6aM/BR+f98BQwhCQZpKLz3auRmTPT2/N4pWA8X1VfcgtvjXSLOyQTdjgCw
        5DXdwG85cgwEQRyXGc4aUhG3P
X-Received: by 2002:a0c:9e65:: with SMTP id z37mr23932532qve.39.1604352304133;
        Mon, 02 Nov 2020 13:25:04 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxkIen1WxObQhiBFilRgn0oiKxkscksHmJoYZSNhTeZY3UShOgAtjQGKu6TtMww+h5CYXJCkg==
X-Received: by 2002:a0c:9e65:: with SMTP id z37mr23932523qve.39.1604352303964;
        Mon, 02 Nov 2020 13:25:03 -0800 (PST)
Received: from xz-x1 (bras-vprn-toroon474qw-lp130-20-174-93-89-196.dsl.bell.ca. [174.93.89.196])
        by smtp.gmail.com with ESMTPSA id p2sm4590055qkk.34.2020.11.02.13.25.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2020 13:25:03 -0800 (PST)
Date:   Mon, 2 Nov 2020 16:25:01 -0500
From:   Peter Xu <peterx@redhat.com>
To:     Ben Gardon <bgardon@google.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Andrew Jones <drjones@redhat.com>,
        Peter Shier <pshier@google.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Thomas Huth <thuth@redhat.com>,
        Peter Feiner <pfeiner@google.com>
Subject: Re: [PATCH 2/5] KVM: selftests: Remove address rounding in guest code
Message-ID: <20201102212501.GC20600@xz-x1>
References: <20201027233733.1484855-1-bgardon@google.com>
 <20201027233733.1484855-3-bgardon@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201027233733.1484855-3-bgardon@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 27, 2020 at 04:37:30PM -0700, Ben Gardon wrote:
> Rounding the address the guest writes to a host page boundary
> will only have an effect if the host page size is larger than the guest
> page size, but in that case the guest write would still go to the same
> host page. There's no reason to round the address down, so remove the
> rounding to simplify the demand paging test.
> 
> This series was tested by running the following invocations on an Intel
> Skylake machine:
> dirty_log_perf_test -b 20m -i 100 -v 64
> dirty_log_perf_test -b 20g -i 5 -v 4
> dirty_log_perf_test -b 4g -i 5 -v 32
> demand_paging_test -b 20m -v 64
> demand_paging_test -b 20g -v 4
> demand_paging_test -b 4g -v 32
> All behaved as expected.
> 
> Signed-off-by: Ben Gardon <bgardon@google.com>

Nit: would be better to be before the code movement.  In all cases:

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu

