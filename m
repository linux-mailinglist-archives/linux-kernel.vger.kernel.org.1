Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1ABAF2A35F9
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Nov 2020 22:27:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726489AbgKBV1W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Nov 2020 16:27:22 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:39701 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725929AbgKBV1V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Nov 2020 16:27:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1604352440;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=AcZsDHqiU0z9govFV78wlNAx19ATsA9/xILzMrob+9I=;
        b=NL36DgANBl7bthatcKwu2QJSXovwZegzL0O90/1V0QU0KCJX3JGbwaGXoHnuSIkb3HC6FS
        b+YA1RccLqrIHkhaokgva7tQzB7z1WBKOpZNFaVDy+n3lYfde7hDZmWKUHxJmkJaFjWZ+8
        U+LjyFStQZHFi6ONhuhYTTbwWOZoAs4=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-310-s9o7go72NIa3mPGW4S5TAw-1; Mon, 02 Nov 2020 16:27:18 -0500
X-MC-Unique: s9o7go72NIa3mPGW4S5TAw-1
Received: by mail-qt1-f199.google.com with SMTP id u28so2603511qtv.20
        for <linux-kernel@vger.kernel.org>; Mon, 02 Nov 2020 13:27:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=AcZsDHqiU0z9govFV78wlNAx19ATsA9/xILzMrob+9I=;
        b=R2VxMENHpFBhZVy1Wp0pHHeJ86TrqIWWdIAUnU0K937inBipK2oKzuj06XraRYqnTq
         5l25b3gHMDKgQVZZGg3JHYIkMIU91+LBwd17SxoC2q7VLja8L3jVBJ5HNSZro13xlfX8
         GF4bvaRYOT9HyuxXKMFO5ON098GR8nduFWCKYkmTm93CAR+QerfJj/qDy2cW5p6EmK25
         9klaTt2xR6k3M+7tdw2JLUZ0jHk4Wur/2gzdFJ51V9mNrwFsxlxc1nHWzEhbhbJsCzpB
         ASwon3/unSuW2smzgIYcL1qCyc2PzevCV9mtKrwAA4RCFkt4J+/H8dcNPG2SFX/p01i/
         IYYQ==
X-Gm-Message-State: AOAM533WRihMKuw+AhIpsQYJMFF92fVdkB2xxPK5I/CtYK8xiMI481gy
        fx4gpz8HfQ6cYbZIx3h5RTHWgzp+zihoYq1P2VpDGIEhNiVDv5fU8oNb/260KfDQtOe/lP922jP
        G94WVvZxtmNosze2D0fybVQKj
X-Received: by 2002:a37:6149:: with SMTP id v70mr16390916qkb.188.1604352438283;
        Mon, 02 Nov 2020 13:27:18 -0800 (PST)
X-Google-Smtp-Source: ABdhPJx1BX1HFiblt+dhs6jzM4c/cLeLDSoTUTDjBFSoL2oLT5fjFR9ZaovZujpYbCENwpT9VuNZRQ==
X-Received: by 2002:a37:6149:: with SMTP id v70mr16390897qkb.188.1604352438101;
        Mon, 02 Nov 2020 13:27:18 -0800 (PST)
Received: from xz-x1 (bras-vprn-toroon474qw-lp130-20-174-93-89-196.dsl.bell.ca. [174.93.89.196])
        by smtp.gmail.com with ESMTPSA id f21sm5206440qkl.131.2020.11.02.13.27.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2020 13:27:17 -0800 (PST)
Date:   Mon, 2 Nov 2020 16:27:15 -0500
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
Subject: Re: [PATCH 3/5] KVM: selftests: Simplify demand_paging_test with
 timespec_diff_now
Message-ID: <20201102212715.GD20600@xz-x1>
References: <20201027233733.1484855-1-bgardon@google.com>
 <20201027233733.1484855-4-bgardon@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201027233733.1484855-4-bgardon@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 27, 2020 at 04:37:31PM -0700, Ben Gardon wrote:
> Add a helper function to get the current time and return the time since
> a given start time. Use that function to simplify the timekeeping in the
> demand paging test.

Nit: timespec_diff_now() sounds less charming than timespec_elapsed() to
me... "diff_now" is longer, and it also does not show positive/negative of the
results (which in this case should always be end-start). "elapsed" should
always mean something positive.

With/Without the change above:

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu

