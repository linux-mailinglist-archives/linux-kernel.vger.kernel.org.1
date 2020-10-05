Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D63A1284332
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Oct 2020 02:14:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726754AbgJFAOk convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 5 Oct 2020 20:14:40 -0400
Received: from elephants.elehost.com ([216.66.27.132]:24756 "EHLO
        elephants.elehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725865AbgJFAOk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Oct 2020 20:14:40 -0400
X-Greylist: delayed 1941 seconds by postgrey-1.27 at vger.kernel.org; Mon, 05 Oct 2020 20:14:39 EDT
X-Virus-Scanned: amavisd-new at elehost.com
Received: from gnash (CPE00fc8d49d843-CM00fc8d49d840.cpe.net.cable.rogers.com [173.32.57.223])
        (authenticated bits=0)
        by elephants.elehost.com (8.15.2/8.15.2) with ESMTPSA id 095NgCFw091147
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Mon, 5 Oct 2020 19:42:13 -0400 (EDT)
        (envelope-from rsbecker@nexbridge.com)
From:   "Randall S. Becker" <rsbecker@nexbridge.com>
To:     "'Junio C Hamano'" <gitster@pobox.com>, <git@vger.kernel.org>
Cc:     "'Linux Kernel'" <linux-kernel@vger.kernel.org>,
        <git-packagers@googlegroups.com>
References: <xmqqa6x070tn.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqqa6x070tn.fsf@gitster.c.googlers.com>
Subject: RE: [ANNOUNCE] Git v2.29.0-rc0
Date:   Mon, 5 Oct 2020 19:42:03 -0400
Message-ID: <029101d69b71$2620ecb0$7262c610$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-ca
Thread-Index: AQMIzznH8O/y4dzt8Qo74xBDvobD46clQ0xQ
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On October 5, 2020 6:41 PM, Junio C Hamano wrote:
> An early preview release Git v2.29.0-rc0 is now available for
> testing at the usual places.  It is comprised of 588 non-merge
> commits since v2.28.0, contributed by 76 people, 22 of which are
> new faces.

NonStop build/tests are running. Will let you know the status.

Please let me know when you would like git tested with OpenSSL 3.0.0. We are waiting on the GA release otherwise.

Regards,
Randall

