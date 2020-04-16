Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 823C01AB9B3
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Apr 2020 09:21:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439082AbgDPHVH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Apr 2020 03:21:07 -0400
Received: from sonic310-23.consmr.mail.ne1.yahoo.com ([66.163.186.204]:33670
        "EHLO sonic310-23.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2438102AbgDPHU7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 03:20:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1587021658; bh=NajTNMrfMLb6UXcjRhYpYerQX8PtVBLz0oFgaMINSWY=; h=Date:From:Reply-To:Subject:References:From:Subject; b=V6yc6cFlGHAADFOFsh7t/Of5emr3FAlXjsaoRyK47pAF8aEEZzp29RGTF+5JuZ0CHuVIazFwuy6V69noSEXxcbRTK4NzuVdjywiiG0efQcOBrdH+MJMBrp/mOdwB7qNWPWldeWXxodKyxTCV2UnF7skHg9tzKccimuunKzKF/i4EdDbBdrBJE3YejVdE44A4PHwQv1R5QZO1KVeT//oKioy+q8UsyBIiwVrT8kciIjcFcp95cxqUd4gyaHo3YZZw96XT4f183W26kzkQDzmfx2n+VYlRtDPFp4vNtviwIf28MfwHfcUB+8Huhj7aTsFysGZqnA26nurdpmYD9htTNg==
X-YMail-OSG: dZCQDX8VM1nZIREQorXZrdend._TVKe0HUszqaXSpTKWmNHmOj8zhHO9WrqfoOa
 4z84Q.0QD4m1WIL6ibrXUQuSA3nNC6RuXCSxB9Ti0mloX65tcquPvAcmY6UoVA7jju1dCAurM8z5
 IoIqQy4Xe4HHNjnW4ep2k2LXnIyVuVjFTT3UnztHTJzpEiKUOZjaXf8y5wlGCSW7DcXg2RlQ.seW
 DnKSObXvjx2Sz3c0CCYC0iylwxfM_m3brRuORiyBKPH49tDqvys8mJR3uG2ePW9l15jIRTSVmBOc
 MhHC8csXhWf2ixYMiPWSeevAhBBuHPOXbjeP6ZGOkTO6ImxXUWvWFxoADHjWhoMazYSsPUa6Lbn4
 uUNESVlPCmspaRQ22C7yfniJeyBTV5dQ8FkIvK3MK.8bdlUvTuGro.aWskitky6f8eUoLAOTk90m
 fd7XkSVtYZ2jUVh.xhIu3EVBHuH.0X_LVE4InyykoF_iZmdpPRBJyAR.G.xrp54HrfCE4SQlFr4t
 ZYh6Heluq_8r.ycGxEcxjN_Rj6TKAQ0m9hoUNcUfQNpbx5gGZ9JVgoRLX7_rnuksZfQesFG9ObVb
 qmKEi6iU1BzTJiuY5p8SgWBqNzDyeY2MrmocNlwH1TBR9mtAP_V5qRh4gmRf2Nxu3QnxTs1BfcqD
 YZe15Ic3XdYJ9GVj8zzERO21h9P3a6U9VFhsdEyH_k6UdTYvEx.NqpG15B3hYZVS25dI1VL85AD6
 VBIRGYHFtJNAyG_pMyjtaQrGVNoMK9YLnz_wxmG6BjBQGQnAEHqp7loyQBw0brDgpAJY0GrEzqFp
 kM.i4JQtjLGmOrlRhCntrlXXqyfy2bam2.r1ivM4ZEFsjZZfVnT_BYlbS.yywL2Ak0CvjAS0kmdt
 xJkIve4xJeZPJLjC4zQXfL5MIAL6iNCI19R7qewdCPVBYuOdg35bBzEfpLZ_O91fH7CKpTyfhA2D
 iK.9k_2PHkcJzR6OKo05vFXtAXvWLqbZFSBNLSpHFQIGVXUMSgIJlQ6A6a0UXwt6g9A_zugEUAUF
 k00tLR1XQ5Q7LQV5bR8U7mQnX4VvR2tCGGYTXKPgWL37L3Of8gFt3b3Oiwubg6v8ZBeTbodljMuY
 hUoVxxKy6oIgzSV39jvimqhgtYpNv8FiDMtM37uitHqPYPqla3QLMjpgVRskEjuIXrHHA7XQ34dD
 FgosNxRrJZ_t_ulA90CLc1zpO.XfQDtTn0Z.GWUjviEuH9bqt0xqZT_FDKEgVafLFGeR9Z4Mq2N4
 HYj8TV_L26YdwL_sFgZUY3nyeJiPgALqBfqj5dpqnQ7R8c373LKCbPNsjngxcYG80rJVcbZ0-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic310.consmr.mail.ne1.yahoo.com with HTTP; Thu, 16 Apr 2020 07:20:58 +0000
Date:   Thu, 16 Apr 2020 07:20:55 +0000 (UTC)
From:   Ms lisa Hugh <lisahugh531@gmail.com>
Reply-To: ms.lisahugh000@gmail.com
Message-ID: <1528215646.1410308.1587021655760@mail.yahoo.com>
Subject: READ AND REPLY FROM MS LISA TRANSFER BUSINESS.
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
References: <1528215646.1410308.1587021655760.ref@mail.yahoo.com>
X-Mailer: WebService/1.1.15651 YMailNodin Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:75.0) Gecko/20100101 Firefox/75.0
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Dear Friend,

I am Ms Lisa hugh, work with the department of Audit and accounting manager here in the Bank(B.O.A).

Please i need your assistance for the transferring of thIs fund to your bank account for both of us benefit for life time investment, amount (US$4.5M DOLLARS).

I have every inquiry details to make the bank believe you and release the fund in within 5 banking working days with your full co-operation with me for success.

Note/ 50% for you why 50% for me after success of the transfer to your bank account.

Below information is what i need from you so will can be reaching each other

1)Full name ...
2)Private telephone number...
3)Age...
4)Nationality...
5)Occupation ...


Thanks.

Ms Lisa hugh.
