Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 065F723E869
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Aug 2020 09:56:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726796AbgHGH4J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Aug 2020 03:56:09 -0400
Received: from sonic302-19.consmr.mail.ir2.yahoo.com ([87.248.110.82]:45905
        "EHLO sonic302-19.consmr.mail.ir2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725805AbgHGH4I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Aug 2020 03:56:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1596786966; bh=Z9vsd41Fm7Z/yq5jTLtgMDMwEzBsZK/n03hNCpbaf3Q=; h=Date:From:Reply-To:Subject:References:From:Subject; b=gzdMJqYz8d6XEZiYQDwTx9hJfnbhl+0I37GB77PnFfyRm9o22g1nl4GyUs/xlhk1v/8Sq6fGJGFlA++yNuZOPZpYcjXY7oPGZ0LL0YaxlDfJfOTZi1aoNreScg16jL3nwQAemIaSHTk+esi7VTskQBsHvfqx/Yx+anbut8SkCduY9lQIpjgxK9GcXtK9op2CBGbJv8JaYqZfY8p7z2yj6VnXUQHcHabrBHq/dcixpMBtgs7q2Jkwg/t0CGVQjOq9+NDdglpHtT/4cl95Y61CWkTvosaQ1xge4c4JReJ/WPdj+wvJz4r/qY5B0OWMjFYPIM4j9TUWbC7yuwofAMoPHA==
X-YMail-OSG: gFdNqAEVM1mcHepdS68umZH2EozI5w2.0524tCE9nPKA2Ih0oqJqUF6OizlN5tr
 wyOArtS.TD6FW_9XU4.RK0clcEW59XyhZpyHBtRlkcGbFTd4WITFa9vX3xZnFiyUonlUmmIOsIZE
 hTtbH58cIZjZqCcrVVsMw3AAgMUCq0QCjbdY10SA6OfarrAZL9iBhlWB8chQQ9YDkkh_wcaiTxNW
 YFzXrLd5HOeBfiAnwcMiTDILdxYT5nSon8HUuD1DIxyItzIdLf4hzu4l9esBHUpn3WCoE9ZY0gOF
 yrKTAn8XFc2JifiXxyJeDb5RYptrdnPdmWkmLRUtlvw3gUboADpwT6kvlkis_dGZD9ykS.e7nNMV
 trKkxjWCyt7k1T1Ag7bg.WoJ1jX4W6TfPHq480q8LEJ6kfSw7O0zOwtWnEvsz4SkAZ6H9Cf0e6ND
 dePy92bGEGnDvxgx1tDM..Bi.w740W1VCp0uQPZUPkRBD51FuCD6Jd8u0JJ6io547xrbV9FAzoUZ
 S1cVxlVpnlzmmzANa.GFyk2.JRy5AmxiqiL9aIINyp9HmUUGu8mQmMLWPE1HZEp04bSLKIIbSpX2
 GTTwb9FnnHxYcaLmsDBF8vB2zMRK1IeRpKibUbbdesitNddUkpMMIcjWuaI1byEXgXHBuF2bZYwQ
 8fdnYvmNAlAaQD6CBvxSdZkQmh0xyCTg9LDk23wzT.LKTjO5uoSLa.ykCk51CsalSaskVcXX5yeo
 pF18B8EAXABQxvDj9ptfeF.fVRlA5Bw4.Z5dcacLMs8Y_wjcrBmaLnqOlM_18o_lu39KJ_v_fHmK
 70Sx0yGHBqascKi5lEmjGriYRpQ9NKAFy4z7FJTB7FsjGvsHPvoY1xP8kSw.XYF_Cb91d3Qxsdr1
 79LMSha97xPPjhZTB6K80Hw0f.q3LUHo7laR5dr9.68_W2QCKdcq52_eHgY4nRmhAuUO8LGqDDn9
 Sni5RfI9OvHwZqnQ2PbHomzwas8lBxoI7VXd2mrFngBOzDpuRZDKwqJ6lupvd1GXlniQgjfJsBdF
 6FiVqm3G22LBdOMnlarWGTHPejT4hOZKjRBymIAJhDQHDTswV_1lQ5fLtXwx_MUn60WioLF5TV5i
 OQwIrQ2Ktm4Lwm6mDYAWJK61CKXNGvVtdQHdLOr6lCOCkWnoVE2uJcf2yqSzgxqEJyJdsfVje7Yk
 zbJiGl40HQB4Ceojzj0PFgigwo90_7TmR.WCTihrNnH6iaOQbv8F3FCyiiWWc92HXLNFdK2o6a1D
 y5GXTrwDm_A72H.OFh6EGmlBRdaXmCxAHi7VIOfwBtIv6f.an6ZfNvBLRKR6edhnUBSSMaFBBMyl
 oUQVaU8VkPsrp.LnMqMy5R2v_oCxSRnYAlp0TXkz5Eh3_8WA-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic302.consmr.mail.ir2.yahoo.com with HTTP; Fri, 7 Aug 2020 07:56:06 +0000
Date:   Fri, 7 Aug 2020 07:56:02 +0000 (UTC)
From:   Sergeant Katie Brianna Taylor <katiebrannataylor07@gmail.com>
Reply-To: katiebriannataylor07@hotmail.com
Message-ID: <533534290.1680462.1596786962045@mail.yahoo.com>
Subject: FROM SERGEANT KATIE B. TAYLOR ,
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
References: <533534290.1680462.1596786962045.ref@mail.yahoo.com>
X-Mailer: WebService/1.1.16436 YMailNodin Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/84.0.4147.105 Safari/537.36
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



I=C2=A0am=C2=A0Sergeant=C2=A0Katie=C2=A0Brianna=C2=A0Taylor,=C2=A0originall=
y=C2=A0from=C2=A0Lake=C2=A0Jackson=C2=A0Texas.=C2=A0I=C2=A0have=C2=A0person=
ally=C2=A0conducted=C2=A0a=C2=A0special=C2=A0research=C2=A0on=C2=A0the=C2=
=A0internet=C2=A0and=C2=A0came=C2=A0across=C2=A0your=C2=A0information.=C2=
=A0I=C2=A0am=C2=A0writing=C2=A0you=C2=A0this=C2=A0mail=C2=A0from=C2=A0US=C2=
=A0Military=C2=A0Base=C2=A0Kabul=C2=A0Afghanistan.=C2=A0I=C2=A0have=C2=A0a=
=C2=A0secured=C2=A0business=C2=A0proposal=C2=A0for=C2=A0you.=C2=A0If=C2=A0y=
ou=C2=A0are=C2=A0interested=C2=A0in=C2=A0my=C2=A0private=C2=A0email=C2=A0(k=
atiebriannataylor07@hotmail.com),=C2=A0please=C2=A0contact=C2=A0me=C2=A0imm=
ediately=C2=A0for=C2=A0more=C2=A0information.

Thank=C2=A0you.
