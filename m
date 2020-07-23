Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03F5122A8CB
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jul 2020 08:17:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727850AbgGWGRC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jul 2020 02:17:02 -0400
Received: from foss.arm.com ([217.140.110.172]:39672 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726522AbgGWGRC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jul 2020 02:17:02 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A8F0730E;
        Wed, 22 Jul 2020 23:17:01 -0700 (PDT)
Received: from [10.163.85.73] (unknown [10.163.85.73])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 78EB73F66E;
        Wed, 22 Jul 2020 23:16:59 -0700 (PDT)
Subject: Re: [PATCH v2 4/4] mm/hugetl.c: warn out if expected count of huge
 pages adjustment is not achieved
To:     Baoquan He <bhe@redhat.com>, linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, mike.kravetz@oracle.com, david@redhat.com,
        akpm@linux-foundation.org
References: <20200723032248.24772-1-bhe@redhat.com>
 <20200723032248.24772-5-bhe@redhat.com>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <62c8ce6c-fe98-f371-99b6-cfdb96d1c2fd@arm.com>
Date:   Thu, 23 Jul 2020 11:46:30 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20200723032248.24772-5-bhe@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 07/23/2020 08:52 AM, Baoquan He wrote:
> A customer complained that no message is logged wh	en the number of
> persistent huge pages is not changed to the exact value written to
> the sysfs or proc nr_hugepages file.
> 
> In the current code, a best effort is made to satisfy requests made
> via the nr_hugepages file.  However, requests may be only partially
> satisfied.
> 
> Log a message if the code was unsuccessful in fully satisfying a
> request. This includes both increasing and decreasing the number
> of persistent huge pages.

But is kernel expected to warn for all such situations where the user
requested resources could not be allocated completely ? Otherwise, it
does not make sense to add an warning for just one such situation.
