Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35B832D4A36
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Dec 2020 20:31:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387758AbgLITbP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Dec 2020 14:31:15 -0500
Received: from mail.draxit.de ([78.47.242.75]:60873 "EHLO mail.draxit.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387719AbgLITa4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Dec 2020 14:30:56 -0500
X-Greylist: delayed 371 seconds by postgrey-1.27 at vger.kernel.org; Wed, 09 Dec 2020 14:30:55 EST
Received: from loki.datenwolf.net (55d46076.access.ecotel.net [85.212.96.118])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.draxit.de (Postfix) with ESMTPSA id DB1091C03D
        for <linux-kernel@vger.kernel.org>; Wed,  9 Dec 2020 20:23:58 +0100 (CET)
To:     LKML Mailing List <linux-kernel@vger.kernel.org>
From:   Wolfgang Draxinger <list@datenwolf.net>
Subject: Does SCM_RIGHTS limit on fd array apply to a particular cmsghdr or
 the whole ancillary data?
Message-ID: <82d68b42-8dc1-7730-a173-3ae7c44bcb16@datenwolf.net>
Date:   Wed, 9 Dec 2020 20:23:58 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

in the documentation on SCM_RIGHTS the maximum number of file
descriptors that can be passed is described as (release 5.09 of the
Linux man-pages project):

| SCM_RIGHTS
|   Send or receive a set of open file descriptors from another
|   process. The data portion contains an integer array of the file
|   descriptors.
| (...)
|   The kernel constant SCM_MAX_FD defines a limit on the number of
        |   file descriptors in the array.  Attempting to send an array
            |   larger than this limit causes sendmsg(2) to fail with
the error              |   EINVAL.

In my reading this might be interpreted as SCM_MAX_FD per SCM_RIGHTS
cmsghdr, xor SCM_MAX_FD per sendmsg. It would be good to know, which one
it is. So which is the proper strategy if I have to pass more than
SCM_MAX_FD file descriptors between processes?


Cheers,
Wolfgang
