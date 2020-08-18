Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50BA124823D
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Aug 2020 11:51:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726671AbgHRJvV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Aug 2020 05:51:21 -0400
Received: from goliath.siemens.de ([192.35.17.28]:34007 "EHLO
        goliath.siemens.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726353AbgHRJvT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Aug 2020 05:51:19 -0400
Received: from mail2.sbs.de (mail2.sbs.de [192.129.41.66])
        by goliath.siemens.de (8.15.2/8.15.2) with ESMTPS id 07I9pCep007193
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 18 Aug 2020 11:51:12 +0200
Received: from [139.22.40.250] ([139.22.40.250])
        by mail2.sbs.de (8.15.2/8.15.2) with ESMTP id 07I9pBnZ027883;
        Tue, 18 Aug 2020 11:51:12 +0200
Subject: Re: [PATCHv2 0/2] scripts:gdb: Add few structs info in gdb scripts
To:     Ritesh Harjani <riteshh@linux.ibm.com>,
        Kieran Bingham <kbingham@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org
References: <cover.1597742951.git.riteshh@linux.ibm.com>
From:   Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <21dbdcfe-7579-4eca-506c-cd5b77c5b34d@siemens.com>
Date:   Tue, 18 Aug 2020 11:51:11 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <cover.1597742951.git.riteshh@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18.08.20 11:34, Ritesh Harjani wrote:
> I was using these structs info internally in my gdb scripts.
> So sending it out for merge to upstream.
> Patch-2 is just adding some headers and improves spacing.
> 

Both patches

Reviewed-by: Jan Kiszka <jan.kiszka@siemens.com>

Jan

--
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux
